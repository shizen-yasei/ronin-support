# Ronin Support

* [Source](http://github.com/ronin-ruby/ronin-support)
* [Issues](http://github.com/ronin-ruby/ronin-support/issues)
* [Documentation](http://rubydoc.info/github/ronin-ruby/ronin-support/frames)
* [Mailing List](http://groups.google.com/group/ronin-ruby)
* irc.freenode.net #ronin

## Description

Ronin Support is a support library for Ronin. Ronin Support contains many of
the convenience methods used by Ronin and additional libraries.

Ronin is a Ruby platform for exploit development and security research.
Ronin allows for the rapid development and distribution of code, exploits
or payloads over many common Source-Code-Management (SCM) systems.

## Features

* Provides convenience methods for:
  * Formatting data:
    * Binary
    * Text
    * HTTP
    * URIs
  * Generating random text.
  * Networking:
    * TCP
    * UDP
    * SMTP / ESMTP
    * POP3
    * Imap
    * Telnet
    * HTTP / HTTPS
  * Enumerating IP ranges:
    * IPv4 / IPv6 addresses.
    * CIDR / globbed ranges.
  * (Un-)Hexdumping data.
  * Handling exceptions.

## Examples

For examples of the convenience methods provided by ronin-support,
please see [Everyday Ronin](http://ronin-ruby.github.com/resources/everyday_ronin.html).

## Requirements

* [Ruby](http://www.ruby-lang.org/) >= 1.8.7
* [chars](http://github.com/postmodern/chars) ~> 0.1.2
* [data_paths](http://github.com/postmodern/data_paths) ~> 0.2.0
* [uri-query_params](http://github.com/postmodern/uri-query_params) ~> 0.5.0

## Install

    $ sudo gem install ronin-support

## License

Copyright (c) 2006-2011 Hal Brodigan (postmodern.mod3 at gmail.com)

This file is part of Ronin Support.

Ronin Support is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Ronin Support is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with Ronin Support.  If not, see <http://www.gnu.org/licenses/>.
