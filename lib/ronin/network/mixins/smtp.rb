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

require 'ronin/network/smtp'

require 'parameters'

module Ronin
  module Network
    module Mixins
      module SMTP
        include Parameters

        # SMTP host
        parameter :host,
                  :type => String,
                  :description => 'SMTP host'

        # SMTP port
        parameter :port,
                  :type => Integer,
                  :description => 'SMTP port'

        # SMTP authentication method
        parameter :smtp_login,
                  :type => String,
                  :description => 'SMTP authentication method'

        # SMTP user to login as
        parameter :smtp_user,
                  :type => String,
                  :description => 'SMTP user to login as'

        # SMTP user to login with
        parameter :smtp_password,
                  :type => String,
                  :description => 'SMTP password to login with'

        protected

        #
        # @see Ronin::Network::SMTP.message
        #
        # @since 0.3.0
        #
        def smtp_message(options={},&block)
          Network::SMTP.message(options,&block)
        end

        #
        # Creates a connection to the SMTP server. The `host`, `port`,
        # `smtp_login`, `smtp_user` and `smtp_password` instance
        # methods will also be used to connect to the server.
        #
        # @param [Hash] options
        #   Additional options.
        #
        # @option options [Integer] :port (Ronin::Network::SMTP.default_port)
        #   The port to connect to.
        #
        # @option options [String] :helo
        #   The HELO domain.
        #
        # @option options [Symbol] :auth
        #   The type of authentication to use. Can be either `:login`,
        #   `:plain` or `:cram_md5`.
        #
        # @option options [String] :user
        #   The user-name to authenticate with.
        #
        # @option options [String] :password
        #   The password to authenticate with.
        #
        # @yield [session]
        #   If a block is given, it will be passed an SMTP session object.
        #
        # @yieldparam [Net::SMTP] session
        #   The SMTP session.
        #
        # @return [Net::SMTP]
        #   The SMTP session.
        #
        # @since 0.3.0
        #
        def smtp_connect(options={},&block)
          options[:port] ||= self.port
          options[:login] ||= self.smtp_login
          options[:user] ||= self.smtp_user
          options[:password] ||= self.smtp_password

          if self.port
            print_info "Connecting to #{self.host}:#{self.port} ..."
          else
            print_info "Connecting to #{self.host} ..."
          end

          return ::Net.smtp_connect(self.host,options,&block)
        end

        #
        # Starts a session with the SMTP server. The `host`, `port`,
        # `smtp_login`, `smtp_user` and `smtp_password` instance
        # methods will also be used to connect to the server.
        #
        # @yield [session]
        #   If a block is given, it will be passed an SMTP session object.
        #   After the block has returned, the session will be closed.
        #
        # @yieldparam [Net::SMTP] session
        #   The SMTP session.
        #
        # @see smtp_connect
        # @since 0.3.0
        #
        def smtp_session(options={},&block)
          smtp_connect(options) do |sess|
            block.call(sess) if block
            sess.close

            if self.port
              print_info "Disconnecting to #{self.host}:#{self.port}"
            else
              print_info "Disconnecting to #{self.host}"
            end
          end
        end
      end
    end
  end
end
