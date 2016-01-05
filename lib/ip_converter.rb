require 'ipaddr'

class IpConverter
  attr_reader :ip_address

  # Public: Initialize a new ip address object
  #
  # ip_address  - The ip address
  # socket_type - The address familly of this ip address.
  #                 Socket::AF_INET for ip v4
  #                 Socket::AF_INET6 for ip 6
  #
  # Examples
  #
  #   IpLookUp.new("192.168.0.1", Socket::AF_INET)
  #
  #   IpLookUp.new("ff02::1", Socket::AF_INET6)
  #
  # Returns the object
  def initialize(ip_address, socket_type)
    @ip_address = IPAddr.new(ip_address, socket_type)
  end

  # Public: Convert an ip address object to integer
  #
  # Examples
  #
  #   ip = IpLookUp.new("192.168.0.1", Socket::AF_INET)
  #   ip.to_integer
  #   # => 3232235521
  #
  #   ip = IpLookUp.new("ff02::1", Socket::AF_INET6)
  #   ip.to_integer
  #   # => 338963523518870617245727861364146307073
  #
  # Returns an Integer value
  def to_integer
    ip_address.to_i
  end
end
