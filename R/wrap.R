
.fmt <- function(s, ...) {
    n <- ...length()
    v <- character(n)
    for (i in seq_len(n)) v[i] <- format(...elt(i))
    RcppSpdlog::formatter(s, v)         # actual fmtlib::fmt formatting
}

##' Convenience Wrappers for 'RcppSpdlog' Logging From 'spdlog'
##'
##' Several short wrappers for functions from 'RcppSpdlog' package are provided
##' as a convenience.  Given the potential for clashing names of common and popular
##' functions names we do \emph{not} recommend the import the whole package but rather
##' do \code{importFrom(RcppSpdlog, set_pattern)} (or maybe \code{importFrom(RcppSpdlog,
##' set_pattern)}). After that, functionality can be accessed via a convenient shorter
##' form such as for example \code{spdl::info()} to log at the \sQuote{info} level.
##' Format strings suitable for the C++ library \sQuote{fmtlib::fmt} and its
##' \code{fmt::format()} (which as of C++20 becomes \sQuote{std::fmt}) are supported
##' so the \code{\{\}} is the placeholder for simple (scalar) arguments (for which the
##' default R formatter is called before passing on a character representation).
##'
##' @param name Character value for the name of the logger instance
##' @param level Character value for the logging level
##' @param s Character value for pattern, level, or logging message
##' @param ... Supplementary arguments for the logging string
##' @return Nothing is returned from these functions as they are invoked for their side-effects.
##' @examples
##' \dontrun{
##' spdl::setup("exampleDemo", "warn")
##' spdl::info("Not seen as level 'info' below 'warn'")
##' spdl::warn("This warning message is seen")
##' spdl::set_level("info")
##' spdl::info("Now this informational message is seen too")
##' spdl::info("Calls use fmtlib::fmt {} as we can see {}", "under the hood", 42L)
##' }
setup       <- function(name = "default", level = "warn") RcppSpdlog::log_setup(name, level)

##' @rdname setup
drop        <- function(s)       RcppSpdlog::log_drop(s)

##' @rdname setup
set_pattern <- function(s)       RcppSpdlog::log_set_pattern(s)

##' @rdname setup
set_level   <- function(s)       RcppSpdlog::log_set_level(s)

##' @rdname setup
trace       <- function(s, ...)  RcppSpdlog::log_trace(.fmt(s,...))

##' @rdname setup
debug       <- function(s, ...)  RcppSpdlog::log_debug(.fmt(s,...))

##' @rdname setup
info        <- function(s, ...)  RcppSpdlog::log_info(.fmt(s,...))

##' @rdname setup
warn        <- function(s, ...)  RcppSpdlog::log_warn(.fmt(s,...))

##' @rdname setup
error       <- function(s, ...)  RcppSpdlog::log_error(.fmt(s,...))

##' @rdname setup
critical    <- function(s, ...)  RcppSpdlog::log_critical(.fmt(s,...))
