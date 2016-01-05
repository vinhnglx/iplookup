class IpaddressesController < ApplicationController
  include IpUtilities

  def index
    ip_address = ip_params['ip_addr']
    ip_integer = ip_to_integer(ip_address)
    unless ip_v4_valid?(ip_address) || ip_v6_valid?(ip_address)
      render json: { error_message: 'The format of your IP address does not valid!!!' }, status: :bad_request and return
    end
    render json: { error_message: 'Private IP address.' }, status: :not_found and return if private_ip?(ip_integer)
    render json: { error_message: 'Invalid IP address.' }, status: :not_found and return if invalid_ip?(ip_integer, ip_address)

    ip_add = ip_country(ip_integer)
    if !(ip_add.try(:name).nil? && ip_add.try(:code).nil?)
      render json: { country: ip_add.name, code: ip_add.code }, status: :ok
    else
      render json: { error_message: 'The IP is not available' }, status: :not_found
    end
  end

  private

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
