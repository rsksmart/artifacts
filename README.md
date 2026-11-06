# rskj-ubuntu-installer
Source code to build rskj ubuntu installer

# Dockerfiles
Looking for Dockerfiles:
  * rskj running node visit: https://hub.docker.com/r/rsksmart/rskj
  * rskj reproducible visit: https://github.com/rsksmart/reproducible-builds/

# Automated PPA build and publish
1. Edit `rskj-ubuntu-installer/rskj_package_<version>/debian/changelog` files
1. Commit and push tag with format `<CODENAME>-<VERSION>` eg: `FINGERROOT-5.0.0`

# Architectures (x86_64 and ARM)
The Debian packages produced by this repo are **architecture-independent**:

- All `debian/control` files declare `Architecture: all`.
- The payload is a Java `rsk.jar` plus configuration files and a `systemd` unit.

To make the same `.deb` available for additional architectures such as `arm64`:

- Ensure `openjdk-17-jre` exists for the target architecture on your Ubuntu release.
- If you use Launchpad / a PPA, enable the `arm64` architecture for the PPA and for the `rskj` source so Launchpad will publish the package for both `amd64` and `arm64`.
- If you build and host `.deb` files yourself, use the source package produced by `scripts/build.sh` or `scripts/build_from_concourse.sh` and publish it in a repository that exposes both `amd64` and `arm64`.

# Testing the packages
`rskj-ubuntu-installer/tests/maintainer_scripts.sh` builds the `.deb` for every series in an `ubuntu:22.04` container and runs the maintainer scripts against it. Nothing is signed or uploaded.

```
rskj-ubuntu-installer/tests/maintainer_scripts.sh            # all series
rskj-ubuntu-installer/tests/maintainer_scripts.sh noble      # one or more series
```

It needs Docker and takes a few minutes. Per series it checks:
- a fresh install with the debconf answers preseeded succeeds and creates the `rsk` account
- an upgrade from 9.0.4 to 9.0.5 succeeds, leaves 9.0.5 installed and keeps the saved license answer
- `dpkg -P` clears the saved license answer
- no maintainer script redirects stderr to a file named `%1` (`2>%1`)

The container has no JRE, so `java` is stubbed and the package is installed with `--force-depends`. Run it after changing anything under `rskj_package_*/debian/` and when adding a series; it exits non-zero on any failure. The series list is the `ALL_SERIES` variable at the top of the script.
