module IpUtilities
  # Check an ip invalid or not. Invalid IP following ranges
  #   0.0.0.0 - 0.255.255.255 (0 - 16777215): IPv4
  #   :: - ::ffff:0.255.255.255 (0 - 281470698520575): IPv6
  #
  # ip_integer  - integer ip address
  # ip_addr     - ip address.
  #
  # Examples
  #
  #   IPv4:
  #     invalid_ip?(100)
  #     # => true
  #
  #   IPv6:
  #     invalid_ip?(281470698520520)
  #     # => true
  #
  #   invalid_ip?(16777230)
  #   # => false
  # Returns Boolean value
  def invalid_ip?(ip_integer, ip_addr)
    # In case IPv6, need to re-convert from integer to ip address
    ip_ad = IPAddr.new(ip_integer, Socket::AF_INET6).to_s if ip_v6_valid?(ip_addr)
    return ip_exists_in_range?(0, 281_470_698_520_575, ip_integer) if ip_v6_valid?(ip_ad)

    return ip_exists_in_range?(0, 167_772_15, ip_integer)
  end

  # Check an ip private or not. Private IP following ranges
  #   192.168.0.0 (3232235520) - 192.168.255.255 (3232301055)
  #   172.16.0.0 (2886729728) - 172.31.255.255 (2887778303)
  #   10.0.0.0 (167772160) - 10.255.255.255 (184549375)
  #
  # ip_integer  - integer inp address
  #
  # Examples
  #
  #   private_ip?(3232235521)
  #   # => true
  #
  #   private_ip?(2886729730)
  #   # => true
  #
  #   private_ip?(288672)
  #   # => false
  #
  # Returns Boolean value
  def private_ip?(ip_integer)
    ip_exists_in_range?(323_223_552_0, 323_230_105_5, ip_integer) || ip_exists_in_range?(288_672_972_8, 288_777_830_3, ip_integer) ||
      ip_exists_in_range?(167_772_160, 184_549_375, ip_integer)
  end

  # Check an ip exists or not exists in range of country's ip.
  #
  # first_range - first position in a range
  # last_range  - last position in a range
  # ip_integer  - integer ip address
  #
  # Examples
  #
  #   ip_exists_in_range?(23092, 23100, 23095)
  #   # => true
  #
  # Returns Boolean value
  def ip_exists_in_range?(first_range, last_range, ip_integer)
    Range.new(first_range, last_range).include? ip_integer
  end

  # Check ipv4 address format
  #
  # ip_address  - The ip address to check v4 format
  #
  # Examples
  #
  #   ip_v4_valid?("192.168.1.1")
  #   # => true
  #
  #   ip_v4_valid?("192.168.1.555")
  #   # => false
  #
  # Returns the Boolean
  def ip_v4_valid?(ip_address)
    !!(ip_address =~ Resolv::IPv4::Regex)
  end

  # Check ipv6 address format
  #
  # ip_address  - The ip address to check v6 format
  #
  # Examples
  #
  #   ip_v6_valid?("ff02::1")
  #   # => true
  #
  #   ip_v4_valid?("ff02::1::1")
  #   # => false
  #
  # Return the Boolean
  def ip_v6_valid?(ip_address)
    !!(ip_address =~ Resolv::IPv6::Regex)
  end

  # Convert an ipaddress v4 or v6 to an Integer value
  #
  # ip_address  - The ip v4 or v6 address
  #
  # Examples
  #
  #   ip_to_integer("192.168.0.1")
  #   # => 3232235521
  #
  #   ip_to_integer("ff02::1")
  #   # => 338963523518870617245727861364146307073
  #
  # Returns an Integer value
  def ip_to_integer(ip_address)
    return IpConverter.new(ip_address, Socket::AF_INET).to_integer if ip_v4_valid?(ip_address)
    return IpConverter.new(ip_address, Socket::AF_INET6).to_integer if ip_v6_valid?(ip_address)
  end
end
