#
# Ronin - A Ruby platform for exploit development and security research.
#
# Copyright (c) 2006-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ronin/network/tcp'

module Ronin
  module Network
    module Helpers
      module TCP
        protected

        #
        # Opens a TCP connection to the host and port specified by the
        # `host` and `port` instance variables. If the `local_host` and
        # `local_port` instance methods are set, they will be used for
        # the local host and port of the TCP connection.
        #
        # @yield [socket]
        #   If a block is given, it will be passed the newly created socket.
        #
        # @yieldparam [TCPsocket] socket
        #   The newly created TCPSocket object.
        #
        # @return [TCPSocket]
        #   The newly created TCPSocket object.
        #
        # @example
        #   tcp_connect # => TCPSocket
        #
        # @example
        #   tcp_connect do |sock|
        #     sock.write("GET /\n\n")
        #     puts sock.readlines
        #     sock.close
        #   end
        #
        # @since 0.3.0
        #
        def tcp_connect(&block)
          print_info "Connecting to #{self.host}:#{self.port} ..."

          return ::Net.tcp_connect(self.host,self.port,self.local_host,self.local_port,&block)
        end

        #
        # Connects to the host and port specified by the `host` and `port`
        # instance variables, then sends the given data.
        #
        # @param [String] data
        #   The data to send through the connection.
        #
        # @yield [socket]
        #   If a block is given, it will be passed the newly created socket.
        #
        # @yieldparam [TCPsocket] socket
        #   The newly created TCPSocket object.
        #
        # @return [TCPSocket]
        #   The newly created TCPSocket object.
        #
        # @since 0.3.0
        #
        def tcp_connect_and_send(data,&block)
          print_info "Connecting to #{self.host}:#{self.port} ..."
          print_debug "Sending data: #{data.inspect}"

          return ::Net.tcp_connect_and_send(data,self.host,self.port,self.local_host,self.local_port,&block)
        end

        #
        # Creates a TCP session to the host and port specified by the
        # `host` and `port` instance methods.
        #
        # @yield [socket]
        #   If a block is given, it will be passed the newly created socket.
        #   After the block has returned, the socket will be closed.
        #
        # @yieldparam [TCPsocket] socket
        #   The newly created TCPSocket object.
        #
        # @return [nil]
        #
        # @since 0.3.0
        #
        def tcp_session(&block)
          print_info "Connecting to #{self.host}:#{self.port} ..."

          Net.tcp_session(self.host,self.port,self.local_host,self.local_port,&block)

          print_info "Disconnected from #{self.host}:#{self.port}"
          return nil
        end

        #
        # Connects to the host and port specified by the `host` and `port`
        # instance methods, reads the banner then closes the connection.
        #
        # @yield [banner]
        #   If a block is given, it will be passed the grabbed banner.
        #
        # @yieldparam [String] banner
        #   The grabbed banner.
        #
        # @return [String]
        #   The grabbed banner.
        #
        # @example
        #   tcp_banner
        #   # => "220 mx.google.com ESMTP c20sm3096959rvf.1"
        #
        # @since 0.3.0
        #
        def tcp_banner(&block)
          print_debug "Grabbing banner from #{self.host}:#{self.port}"

          return ::Net.tcp_banner(self.host,self.port,self.local_host,self.local_port,&block)
        end

        #
        # Connects to the host and port specified by the `host` and `port`
        # instance methods, sends the given data and then disconnects.
        #
        # @return [true]
        #   The data was successfully sent.
        #
        # @example
        #   buffer = "GET /" + ('A' * 4096) + "\n\r"
        #   Net.tcp_send(buffer)
        #   # => true
        #
        # @since 0.3.0
        #
        def tcp_send(data)
          print_info "Connecting to #{self.host}:#{self.port} ..."
          print_debug "Sending data: #{data.inspect}"

          ::Net.tcp_send(data,self.host,self.port,self.local_host,self.local_port)

          print_info "Disconnected from #{self.host}:#{self.port}"
          return true
        end

        #
        # Creates a new TCPServer object listening on the `server_host`
        # and `server_port` instance methods.
        #
        # @yield [server]
        #   The given block will be passed the newly created server.
        #
        # @yieldparam [TCPServer] server
        #   The newly created server.
        #
        # @return [TCPServer]
        #   The newly created server.
        #
        # @example
        #   tcp_server
        #
        # @since 0.3.0
        #
        def tcp_server(&block)
          if self.server_host
            print_info "Listening on #{self.server_host}:#{self.server_port} ..."
          else
            print_info "Listening on #{self.server_port} ..."
          end

          return ::Net.tcp_server(self.server_port,self.server_host,&block)
        end

        #
        # Creates a new temporary TCPServer object listening on the
        # `server_host` and `server_port` instance methods.
        #
        # @yield [server]
        #   The given block will be passed the newly created server.
        #   When the block has finished, the server will be closed.
        #
        # @yieldparam [TCPServer] server
        #   The newly created server.
        #
        # @return [nil]
        #
        # @example
        #   tcp_server_session do |server|
        #     client1 = server.accept
        #     client2 = server.accept
        #
        #     client2.write(server.read_line)
        #
        #     client1.close
        #     client2.close
        #   end
        #
        # @since 0.3.0
        #
        def tcp_server_session(&block)
          if self.server_host
            print_info "Listening on #{self.server_host}:#{self.server_port} ..."
          else
            print_info "Listening on #{self.server_port} ..."
          end

          ::Net.tcp_server_session(&block)

          if self.server_host
            print_info "Closed #{self.server_host}:#{self.server_port}"
          else
            print_info "Closed #{self.server_port}"
          end

          return nil
        end

        #
        # Creates a new temporary TCPServer object listening on
        # `server_host` and `server_port` instance methods.
        # The TCPServer will accepting one client, pass the newly connected
        # client to a given block, disconnects the client and stops
        # listening.
        #
        # @yield [client]
        #   The given block will be passed the newly connected client.
        #   When the block has finished, the newly connected client and
        #   the server will be closed.
        #
        # @yieldparam [TCPSocket] client
        #   The newly connected client.
        #
        # @return [nil]
        #
        # @example
        #   tcp_single_server do |client|
        #     client.puts 'lol'
        #   end
        #
        # @since 0.3.0
        #
        def tcp_single_server(&block)
          if self.server_host
            print_info "Listening on #{self.server_host}:#{self.server_port} ..."
          else
            print_info "Listening on #{self.server_port} ..."
          end

          ::Net.tcp_single_server do |client|
            client_addr = client.peeraddr
            client_host = (client_addr[2] || client_addr[3])
            client_port = client_addr[1]

            print_info "Client connected #{client_host}:#{client_port}"

            block.call(client) if block

            print_info "Disconnecting client #{client_host}:#{client_port}"
          end

          if self.server_host
            print_info "Closed #{self.server_host}:#{self.server_port}"
          else
            print_info "Closed #{self.server_port}"
          end

          return nil
        end
      end
    end
  end
end