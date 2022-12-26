
.onAttach <- function(libname, pkgname) {
    txt <- paste0("\nThe 'spdl' package is not meant for interactive work following 'library(spdl)'.\n",
                  "Rather, just call its functions directly (e.g. 'spdl::info(\"Some message\")')\n",
                  "without attaching the package.\n")
    packageStartupMessage(txt)
}
