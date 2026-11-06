#!/bin/bash
#
# Builds the rskj .deb for every series in a throwaway container and exercises
# the maintainer scripts: unattended install, upgrade and purge.
#
# usage: tests/maintainer_scripts.sh [series...]    (default: all series)
# requires: docker
#
set -u

ALL_SERIES="bionic focal jammy noble resolute stonking"
LICENSE_Q="shared/accepted-rsk-license-v1-1"

if [ -z "${IN_CONTAINER:-}" ]; then
	root="$(cd "$(dirname "$0")/.." && pwd)"
	exec docker run --rm --platform linux/amd64 -e IN_CONTAINER=1 \
		-v "$root:/src:ro" ubuntu:22.04 bash /src/tests/maintainer_scripts.sh "$@"
fi

SERIES="${*:-$ALL_SERIES}"
PKG=/src
export DEBIAN_FRONTEND=noninteractive

apt-get update -qq >/dev/null
apt-get install -y -qq debhelper dpkg-dev debconf-utils systemd >/dev/null 2>&1
printf '#!/bin/sh\nexit 0\n' >/usr/local/bin/java && chmod +x /usr/local/bin/java

build_deb() { # series version
	local series=$1 version=$2 d=/tmp/build/$1-$2
	rm -rf "$d" && mkdir -p "$d"
	cp -r "$PKG/rskj_package_$series/." "$d/"
	sed -i "s|<V>|$version|g" "$d/debian/control"
	sed -i "1s|(9.0.4~$series)|($version~$series)|" "$d/debian/changelog"
	head -c 1000 /dev/urandom >"$d/src/rsk.jar"
	cp "$PKG"/config/*.conf "$PKG/config/logback.xml" "$d/src/"
	cp "$PKG/init-scripts/rsk.service-node" "$d/src/rsk.service"
	(cd "$d" && dpkg-buildpackage -b -us -uc >/tmp/build/$series-$version.log 2>&1) || {
		echo "build failed for $series $version"; tail -20 "/tmp/build/$series-$version.log"; return 1
	}
}

install_deb() { # series version
	dpkg -i --force-depends "/tmp/build/rskj_$2~$1_all.deb" >/tmp/install.log 2>&1 && return 0
	echo "--- install output ---"; tail -15 /tmp/install.log; echo "---"; return 1
}

reset_state() {
	dpkg -P rskj >/dev/null 2>&1
	userdel rsk >/dev/null 2>&1
	groupdel rsk >/dev/null 2>&1
	echo PURGE | debconf-communicate rskj >/dev/null 2>&1
	rm -rf /etc/rsk /var/lib/rsk /var/log/rsk
}

preseed() {
	printf 'rskj %s boolean true\nrskj shared/config select mainnet\n' "$LICENSE_Q" | debconf-set-selections
}

license_answer_saved() { debconf-get-selections 2>/dev/null | grep -q "$LICENSE_Q.*true"; }
version_is() { [ "$(dpkg-query -W -f='${Version}' rskj 2>/dev/null)" = "$1" ]; }
answer_cleared_by_purge() {
	license_answer_saved && dpkg -P rskj >/dev/null 2>&1 && ! license_answer_saved
}

failures=0
check() { # name command...
	local name=$1; shift
	if "$@"; then echo "PASS $current: $name"; else echo "FAIL $current: $name"; failures=$((failures + 1)); fi
}

for current in $SERIES; do
	build_deb "$current" 9.0.4 && build_deb "$current" 9.0.5 || { failures=$((failures + 1)); continue; }

	reset_state; preseed
	check "preseeded fresh install succeeds" install_deb "$current" 9.0.4
	check "preseeded fresh install creates rsk account" bash -c 'id rsk >/dev/null 2>&1'

	reset_state; groupadd -g 888 rsk; useradd rsk -u 888 -g 888 -s /sbin/nologin
	preseed
	check "install of 9.0.4 succeeds" install_deb "$current" 9.0.4
	check "upgrade to 9.0.5 succeeds" install_deb "$current" 9.0.5
	check "upgrade leaves 9.0.5 installed" version_is "9.0.5~$current"
	check "upgrade keeps the license answer" license_answer_saved
	check "purge clears the saved license answer" answer_cleared_by_purge

	check "no stderr redirect to a file named %1" bash -c '! grep -rn "2>%1" '"$PKG/rskj_package_$current"'/debian'
done

[ "$failures" -eq 0 ] && echo "ALL PASS" || { echo "$failures FAILED"; exit 1; }
