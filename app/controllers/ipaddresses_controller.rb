class IpaddressesController < ApplicationController
  include IpUtilities

  def index
    # Get ip address from ip_addr parameter
    ip_address = ip_params['ip_addr']

    # Converts ip address to integer
    ip_integer = ip_to_integer(ip_address)

    # Returns the error message in case invalid ip format
    invalid_ip_format(ip_address); return if performed?

    # Returns the error message in case invalid ip address or private ip address
    private_invalid_ip(ip_address, ip_integer); return if performed?

    # Returns the country from ip address
    verify_ip(ip_address, ip_integer); return if performed?
  end

  private

    # Render error message for private ip or invalid ip addresses
    #
    # ip_address  - ip address
    # ip_integer  - integer ip address
    #
    # Examples
    #
    #   private_invalid_ip('10.0.0.5', 167772165)
    #   # => { error_message: 'Private IP address.' }
    #
    #   private_invalid_ip('::ffff:0.255.255.200', 281470698520520)
    #   # => { error_message: 'Invalid IP address.' }
    #
    # Returns the json error message
    def private_invalid_ip(ip_address, ip_integer)
      render json: { error_message: 'Private IP address.' }, status: :not_found and return if private_ip?(ip_integer)
      render json: { error_message: 'Invalid IP address.' }, status: :not_found and return if invalid_ip?(ip_integer, ip_address)
    end

    # Render error message for invalid ip format
    #
    # ip_address  - ip address
    #
    # Examples
    #   invalid_ip_format('2309230.209.23929.390923')
    #   # => { error_message: 'The format of your IP address does not valid!!!' }
    #
    # Returns the json error message
    def invalid_ip_format(ip_address)
      unless ip_v4_valid?(ip_address) || ip_v6_valid?(ip_address)
        render json: { error_message: 'The format of your IP address does not valid!!!' }, status: :bad_request and return
      end
    end

    # Verify ip and return country
    #
    # ip_address  - ip address
    # ip_integer  - integer ip address
    #
    # Examples
    #
    #   verify_ip('1.0.1.0', 23092309)
    #   # => { country: 'Viet Nam', code: 'VN' }
    #
    #   verify_ip('127.0.0.1', 23092309)
    #   # => { error_message: 'The IP is not available' }
    #
    # Return the json message
    def verify_ip(ip_address, ip_integer)
      ip_add = ip_country(ip_integer)
      if !(ip_add.try(:name).nil? && ip_add.try(:code).nil?)
        render json: { country: ip_add.name, code: ip_add.code }, status: :ok
      else
        render json: { error_message: 'The IP is not available' }, status: :not_found
      end
    end

    # Permit params ip_addr
    #
    # Examples
    #   ip_params
    #   # => return { "ip_addr": 10.0.0.5 }
    # Returns the Hash value
    def ip_params
      params.permit(:ip_addr)
    end

    # Detect country form the integer ip address
    #
    # ip_integer  - integer ip address
    # ip_address  - ip address
    #
    # Examples
    #
    #   ip_country(16777216)
    #   # => { country: 'Australia', code: 'AU' }
    #
    #   ip_country(16777215)
    #   # => { message: 'Invalid IP address.' }
    #
    #   ip_country(167772165)
    #   # => { message: 'Private IP address.' }
    #
    # Return the range ip
    def ip_country(ip_integer)
      Ipaddress.pluck(:ip_addresses).each do |ip|
        ips = YAML.load(ip)

        if ip_exists_in_range?(ips.first, ips.last, ip_integer)
          return Ipaddress.find_by_ip_addresses(ip)
          break
        end
      end
    end
end
