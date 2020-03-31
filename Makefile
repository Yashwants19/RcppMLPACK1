.ONESHELL:
.PHONY:deps download build clean

TMP_DIR?=/tmp/

RPMS=cmake curl git unzip boost-devel boost-test boost-program-options boost-math armadillo-devel binutils-devel
DEBS=unzip build-essential cmake curl git pkg-config libboost-math-dev libboost-program-options-dev libboost-test-dev libboost-serialization-dev libarmadillo-dev binutils-dev

distro_deps=
ifneq ($(shell which dnf 2>/dev/null),)
	distro_deps=deps_fedora
else
ifneq ($(shell which apt-get 2>/dev/null),)
	distro_deps=deps_debian
else
ifneq ($(shell which yum 2>/dev/null),)
	distro_deps=deps_rh_centos
endif
endif
endif

deps: $(distro_deps)

deps_rh_centos:
	sudo -S yum -y install pkgconfig $(RPMS)

deps_fedora:
	sudo -S dnf -y install pkgconf-pkg-config $(RPMS)

deps_debian:
	sudo -S apt-get -y update
	sudo -S apt-get -y install $(DEBS)


download:
	rm -rf $(TMP_DIR)mlpack
	mkdir $(TMP_DIR)mlpack
	cd $(TMP_DIR)mlpack
	curl -Lo mlpack.zip https://codeload.github.com/Yashwants19/mlpack/zip/go-bindings
	unzip -q mlpack.zip
	rm mlpack.zip
	cd -

build:
	cd $(TMP_DIR)mlpack/mlpack-go-bindings
	mkdir build
	cd build
	cmake -D BUILD_TESTS=OFF -D BUILD_JULIA_BINDINGS=OFF -D BUILD_PYTHON_BINDINGS=OFF -D BUILD_CLI_EXECUTABLES=OFF -D BUILD_GO_BINDINGS=OFF -D BUILD_GO_SHLIB=OFF  ..
	$(MAKE) -j $(shell nproc --all)
	$(MAKE) preinstall
	cd -

clean:
	rm -rf $(TMP_DIR)mlpack

install: deps download build sudo_install clean

sudo_install:
	cd $(TMP_DIR)mlpack/mlpack-go-bindings/build
	sudo -S $(MAKE) install
	sudo -S ldconfig
	cd -
