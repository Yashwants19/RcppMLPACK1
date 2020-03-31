# Bindings to 'mlpack'.
[![Build Status](https://travis-ci.com/Yashwants19/RcppMLPACK.svg?branch=master)](https://travis-ci.com/github/Yashwants19/RcppMLPACK)
## Installation
To install from source on Linux, you need to install the mlpack(3.2.2) library:

```sh
sudo apt-get install libmlpack-dev
```
or

```sh
sudo apt-get install libboost-math-dev libboost-program-options-dev
  libboost-test-dev libboost-serialization-dev libarmadillo-dev binutils-dev
wget https://www.mlpack.org/files/mlpack-3.2.2.tar.gz
tar -xvzpf mlpack-3.2.2.tar.gz
mkdir mlpack-3.2.2/build && cd mlpack-3.2.2/build
cmake -D BUILD_TESTS=OFF -D BUILD_PYTHON_BINDINGS=OFF -D BUILD_CLI_EXECUTABLES=OFF ../
make -j4
sudo make install
sudo ldconfig
```

And then install the R bindings:
```r
devtools::install_github("Yashwants19/RcppMLPACK")
library(RcppMLPACK)
```
or
```sh
git clone https://github.com/Yashwants19/RcppMLPACK.git
cd RcppMLPACK
make install
R CMD build  .
R CMD INSTALL .
R -e 'devtools::test()' #for testing
R CMD check . #for testing
```

## For Documention:

```r
library(RcppMLPACK)
help(testRBinding)
```

## For Testing:

Test RcppMLPACK package with Ctrl + Shift + T(rstudio) or `devtools::test()` in the package folder.
