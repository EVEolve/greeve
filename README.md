# Greeve

[![Gem Version](https://badge.fury.io/rb/greeve.svg)](https://badge.fury.io/rb/greeve)
[![Build Status](https://travis-ci.org/EVEolve/greeve.svg?branch=master)](https://travis-ci.org/EVEolve/greeve)
[![Coverage Status](https://coveralls.io/repos/github/EVEolve/greeve/badge.svg?branch=master)](https://coveralls.io/github/EVEolve/greeve?branch=master)
[![API Documentation](https://img.shields.io/badge/docs-api-blue.svg)](http://www.rubydoc.info/gems/greeve)
[![MIT License](https://img.shields.io/badge/license-MIT-yellowgreen.svg)](https://github.com/EVEolve/greeve/blob/master/LICENSE)

A Ruby wrapper for the [EVE Online XML API](https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/index.html).

## Installation

```text
gem install greeve
```

Greeve delegates HTTP requests to [Typheous](https://github.com/typhoeus/typhoeus),
which requires [libcurl](https://curl.haxx.se/libcurl/) to be installed.

**Linux**

This gem should work with zero or minimal setup on a Linux server. libcurl is
typically either preinstalled or easily obtainable from the package manager.

**Windows**

* Download and unzip **Win64 - Generic:** [Win64 2000/XP x86_64 zip 7.46.0](https://curl.haxx.se/download.html)
* Add the **absolute path** of `curl-7.46.0-win64\dlls` to the [PATH environment variable](https://www.java.com/en/download/help/path.xml)

Note that the `7.46.0` release seems to be the latest one with the precompiled
DLL. `7.50.1` was packaged differently and must be compiled first, which is out
of the scope of this documentation. Refer to [libcurl](https://curl.haxx.se/libcurl/)
for additional information about installation on Windows.
