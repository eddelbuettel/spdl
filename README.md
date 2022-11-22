
## spdl: A consistent C++ and R interface to spdlog

[![CI](https://github.com/eddelbuettel/spdl/actions/workflows/ci.yaml/badge.svg)](https://github.com/eddelbuettel/spdl/actions/workflows/ci.yaml)
[![CRAN](https://www.r-pkg.org/badges/version/spdl)](https://cran.r-project.org/package=spdl)
[![Dependencies](https://tinyverse.netlify.com/badge/spdl)](https://cran.r-project.org/package=spdl)
[![Downloads](https://cranlogs.r-pkg.org/badges/spdl?color=brightgreen)](https://www.r-pkg.org/pkg/spdl)
[![License](https://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](https://www.gnu.org/licenses/gpl-2.0.html)
[![Last Commit](https://img.shields.io/github/last-commit/eddelbuettel/spdl)](https://github.com/eddelbuettel/spdl)

## About

The [RcppSpdlog](https://github.com/eddelbuettel/rcppspdlog) repository (and
[CRAN package](https://cran.r-project.org/package=RcppSpdlog)) provides
access to the wonderful [spdlog](https://github.com/gabime/spdlog) library
along with the [fmt](https://github.com/fmtlib/fmt) library. 

This permits use in C++ extensions for R by offering the
[spdlog](https://github.com/gabime/spdlog) (header-only) library along with
the (header-only) [fmt](https://github.com/fmtlib/fmt) library (by
using `LinkingTo` as described in [Section 1.1.3 of
WRE](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Package-Dependencies)).
More recently,
[RcppSpdlog](https://github.com/eddelbuettel/rcppspdlog) was extended so that it provides
a set of key functions directly for use by other R functions (as described in
[Section 5.4.3 of
WRE](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Linking-to-native-routines-in-other-packages)).

However, now the use of, say, a debug logging message from C++ looks like

```c++
// in C++
spdlog::debug("Text with {} text {} which is {}", "auto", "expansion", 42);
```

whereas in R, given the `RcppSpdlog` package and namespace, it looks like
this (if we use `sprintf()` to assemble the message)

```R
# in R
RcppSpdlog::log_debug(sprintf("Text with %s text %s which is %s", "auto", "expansion", 42L);
```

and that irked us.  Enter this package!  By owning the `spld` namespace (in
R) and an easily overlayed namespace in C++ of the same name we can do


```c++
// in C++
spdl::debug("Text with {} text {} which is {}", "auto", "expansion", 42);
```

as well as (still using `sprintf()`)

```R
# in R
spdl::debug(sprintf("Text with %s text %s which is %s", "auto", "expansion", 42L));
```

which is _much better_ as it avoids context switching. Better still, with the
internal formatter we can write the _same format string as in C++ and not
worry about format details_:

```R
# in R
spdl::debug("Text with {} text {} which is {}", "auto", "expansion", 42L);
```


## Details 

We use a simple mechanism in which all R arguments are passed through
`format()` by default to render strings, and then pass a single vector of
strings argument _through the restrictive C language Foreign Function
Interface_ to [RcppSpdlog](https://github.com/eddelbuettel/rcppspdlog) where
it can be passed to the C++ layer available there.

This also mean we use the [fmt](https://github.com/fmtlib/fmt) library
in both languages as the formatter.  We prefer this is over other
string-interpolating libraries in R which are similar but subtly
different. Should their use be desired, they can of course be used: the
default call to any of the loggers is just a single-argument call with a text
variable so users are free to expand strings as they please.  Anything
starting from `paste` and `sprintf` works.


### Author

[Dirk Eddelbuettel](https://dirk.eddelbuettel.com) 

### License

spdl is released under the GNU GPL, version 2 or later, just like R itself.
