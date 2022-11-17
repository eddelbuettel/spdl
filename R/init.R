
.onAttach <- function(libname, pkgname) {
    packageStartupMessage("\n\nThe 'spdl' package is not meant for interactive work following 'library(spdl)'. ",
                          "Rather, just call it functions 'spdl::info(\"Some message\")' directly without ",
                          "attaching the package.\n\n")
}
