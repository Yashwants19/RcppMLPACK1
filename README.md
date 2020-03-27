# Bindings to 'mlpack'.

## Installation

To install from source on Linux, you need to install the mlpack(3.0.0 or above) library:

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

## For Documention:

```r
library(RcppMLPACK)
 help(testRBinding)
```

## For Testing:

Test RcppMLPACK package with Ctrl + Shift + T(rstudio) or `devtools::test()` in the package folder.


