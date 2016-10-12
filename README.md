# Greeve

[![Gem Version](https://badge.fury.io/rb/greeve.svg)](https://badge.fury.io/rb/greeve)
[![Build Status](https://travis-ci.org/EVEolve/greeve.svg?branch=master)](https://travis-ci.org/EVEolve/greeve)
[![Coverage Status](https://coveralls.io/repos/github/EVEolve/greeve/badge.svg?branch=master)](https://coveralls.io/github/EVEolve/greeve?branch=master)
[![API Documentation](https://img.shields.io/badge/docs-api-blue.svg)](http://www.rubydoc.info/gems/greeve)
[![MIT License](https://img.shields.io/badge/license-MIT-yellowgreen.svg)](https://github.com/EVEolve/greeve/blob/master/LICENSE)

A Ruby wrapper for the [EVE Online XML API](https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/index.html).

```ruby
c = Greeve::Eve::CharacterInfo.new(462421468, key: 1234567, vcode: "abcdefg")
p c.character_name # => "Zaphoon"
p c.ship_type_name # => "Manticore"
```

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

## Documentation

Greeve's namespacing and attributes attempt to follow the [EVE Online Developer
Documentation](https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/index.html)
as closely as possible. Ideally this means you can figure out the Greeve API
if you're familiar with the developer docs. Of course, the [Greeve API](http://www.rubydoc.info/gems/greeve)
is also documented.

### Reading The Source Code

The source code for each EVE XML API endpoint was designed to be easy to read
and self-documenting. This project implements a [domain-specific language](https://en.wikipedia.org/wiki/Domain-specific_language) 
(DSL) to help make this possible. The DSL provides methods like `attribute` and
`rowset` to describe the XML and map it to a Ruby object.

```ruby
module Greeve
  module Server
    class ServerStatus < Greeve::BaseItem
      endpoint "server/ServerStatus"

      attribute :server_open,    xpath: "eveapi/result/serverOpen/?[0]",    type: :boolean
      attribute :online_players, xpath: "eveapi/result/onlinePlayers/?[0]", type: :integer
    end
  end
end
```

Compare this code to the [ServerStatus developer documentation](https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/server/serv_serverstatus.html)
and it should be easy to see how the data is mapped.

### Generating Offline Documentation

Unfortunately [rubydoc.info](http://www.rubydoc.info/gems/greeve) doesn't
execute custom handlers, which Greeve uses to document the DSL helpers like
`attribute` and `rowset`. This can make it difficult to see which attributes a
resource implements without looking at the source code. A better way is to
generate the API documentation locally on your computer.

First, clone down a copy of the Greeve repository:

```text
git clone https://github.com/EVEolve/greeve.git
cd greeve
```

Make sure [bundler](http://bundler.io/) is installed, and install the
gems for the repo:

```text
gem install bundler
bundle install
```

Generate the documentation:

```text
bundle exec rake doc
```

The documentation is now located at `doc/index.html`

## Usage

Since Greeve mirrors the EVE XML API namespace, the server status can be queried
by instantiating the [Server::ServerStatus](https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/server/serv_serverstatus.html)
resource.

```ruby
require "greeve"

server = Greeve::Server::ServerStatus.new
p server.server_open    # => true
p server.online_players # => 27421
```

One difference between the EVE developer documentation is that Greeve follows
Ruby naming conventions and therefore uses snake case (`server_open`) for the
attribute names instead of the camel case (`serverOpen`) convention used in
the XML.

### Using An API Key

When accessing a resource that requires an API key, pass the `key` and `vcode`
into the constructor's `opts`. These parameters can be passed to any resource.
An API key can be obtained from the [EVE API Key Management webpage](https://community.eveonline.com/support/api-key/).

```ruby
c = Greeve::Eve::CharacterInfo.new(462421468, key: 1234567, vcode: "abcdefg")
p c.character_name # => "Zaphoon"
p c.ship_type_name # => "Manticore"
```

### Custom User-Agent

CCP recommends that applications that consume from the API [pass a custom
user-agent](https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/intro.html#user-agent).
Greeve allows you to easily do this.

```ruby
Greeve::Config.user_agent = "My App/1.0.0 - http://www.my-app.com"
```
