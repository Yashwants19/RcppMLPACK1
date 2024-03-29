## RcppMLPACK.package.skeleton.R: makes a skeleton for a package that wants to use RcppMLPACK
##
## Copyright (C)  2016  Qiang Kou
##
## This file is part of RcppMLPACK.
##
## RcppMLPACK is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 2 of the License, or
## (at your option) any later version.
##
## RcppMLPACK distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with RcppMLPACK.  If not, see <http://www.gnu.org/licenses/>.

RcppMLPACK.package.skeleton <- function(name="anRpackage", list=character(),
                                        environment=.GlobalEnv,
                                        path=".", force=FALSE, 
                                        code_files=character(), 
                                        example_code=TRUE) {
  
  env <- parent.frame(1)
  
  if (! length(list)) {
    fake <- TRUE
    assign( "Rcpp.fake.fun", function(){}, envir = env )
  } else {
    fake <- FALSE
  }
  
  ## first let the traditional version do its business
  call <- match.call()
  call[[1]] <- as.name("package.skeleton")
  if ("example_code" %in% names(call)){
    ## remove the example_code argument
    call[["example_code"]] <- NULL
  }
  if (fake) {
    call[["list"]] <- "Rcpp.fake.fun"
  }
  
  tryCatch(eval(call, envir=env),
           error = function(e) {
             stop("error while calling `package.skeleton`")
           })
  
  message("\nAdding RcppMLPACK settings")
  
  ## now pick things up 
  root <- file.path(path, name)
  
  ## Add Rcpp to the DESCRIPTION
  DESCRIPTION <- file.path(root, "DESCRIPTION")
  if (file.exists(DESCRIPTION)) {
    x <- cbind(read.dcf( DESCRIPTION), 
               "Imports" = sprintf("Rcpp (>= %s)", 
                                   packageDescription("Rcpp")[["Version"]]), 
               "LinkingTo" = "Rcpp, RcppMLPACK, RcppArmadillo, BH")
    write.dcf(x, file=DESCRIPTION)
    message(" >> added Imports: Rcpp")
    message(" >> added LinkingTo: Rcpp, RcppMLPACK, RcppArmadillo, BH")
  }
  
  ## add a useDynLib to NAMESPACE, 
  NAMESPACE <- file.path( root, "NAMESPACE")
  lines <- readLines( NAMESPACE )
  if (! grepl("useDynLib", lines)) {
    lines <- c(sprintf("useDynLib(%s)", name),
               "importFrom(Rcpp, evalCpp)",        ## ensures Rcpp instantiation
               lines)
    writeLines(lines, con = NAMESPACE)
    message( " >> added useDynLib and importFrom directives to NAMESPACE")
  }
  
  ## lay things out in the src directory
  src <- file.path(root, "src")
  if (!file.exists(src)) {
    dir.create(src)
  }
  skeleton <- system.file("skeleton", package="RcppMLPACK")
  Makevars <- file.path(src, "Makevars")
  if (!file.exists(Makevars)) {
    file.copy(file.path(skeleton, "Makevars"), Makevars)
    message(" >> added Makevars file with RcppMLPACK settings")
  }
  
  Makevars.win <- file.path(src, "Makevars.win")
  if (! file.exists( Makevars.win)) {
    file.copy(file.path(skeleton, "Makevars.win"), Makevars.win)
    message(" >> added Makevars.win file with RcppMLPACK settings")
  }
  
  if (fake) {
    rm("Rcpp.fake.fun", envir=env)
    unlink(file.path(root, "R"  , "Rcpp.fake.fun.R"))
    unlink(file.path(root, "man", "Rcpp.fake.fun.Rd"))
  }
  
  invisible(NULL)
}
