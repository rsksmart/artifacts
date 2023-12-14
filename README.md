# rskj-ubuntu-installer
Source code to build rskj ubuntu installer

# Dockerfiles
Looking for Dockerfiles:
  * rskj running node visit: https://hub.docker.com/r/rsksmart/rskj
  * rskj reproducible visit: https://github.com/rsksmart/reproducible-builds/

# Automated PPA build and publish
1. Edit `rskj-ubuntu-installer/rskj_package_<version>/debian/changelog` files
1. Commit and push tag with format `<CODENAME>-<VERSION>` eg: `FINGERROOT-5.0.0`
