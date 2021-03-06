#
# Copyright (c) 2006-2011 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of Ronin Support.
#
# Ronin Support is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ronin Support is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with Ronin Support.  If not, see <http://www.gnu.org/licenses/>.
#

require 'ronin/network/extensions/ssl'

module Ronin
  module Network
    #
    # SSL helper methods.
    #
    module SSL
      #
      # Returns the OpenSSL verify mode.
      #
      # @param [Symbol, String] mode
      #   The name of the verify mode.
      #
      # @return [Integer]
      #   The verify mode number used by OpenSSL.
      #
      def SSL.verify(mode=nil)
        verify_mode = 'VERIFY_' + (mode || :none).to_s.upcase

        unless OpenSSL::SSL.const_defined?(verify_mode)
          raise(RuntimeError,"unknown verify mode #{mode}")
        end

        return OpenSSL::SSL.const_get(verify_mode)
      end
    end
  end
end
