require 'rails_helper'

RSpec.describe IpUtilities do
  let(:extended_class) { Class.new { extend IpUtilities } }
  let(:including_class) { Class.new { include IpUtilities } }
  let(:included) { including_class.new }

  context '.invalid_ip?' do
    describe 'ipv4' do
      let(:ip_addr) { '0.0.100.100' }
      let(:ip_addr_out) { '129.20.12.12' }
      let(:ipv4_integer) { IPAddr.new(ip_addr, Socket::AF_INET).to_i }
      let(:ipv4_integer_out) { IPAddr.new(ip_addr_out, Socket::AF_INET).to_i }

      it 'returns true if ip is within range from 0.0.0.0 (0) to 0.255.255.255 (16777215)' do
        expect(extended_class.invalid_ip?(ipv4_integer, ip_addr)).to be_truthy

        expect(included.invalid_ip?(ipv4_integer, ip_addr)).to be_truthy
      end

      it 'returns false if ip is without range from 0.0.0.0 (0) to 0.255.255.255 (16777215)' do
        expect(extended_class.invalid_ip?(ipv4_integer_out, ip_addr_out)).to be_falsy

        expect(included.invalid_ip?(ipv4_integer_out, ip_addr_out)).to be_falsy
      end
    end

    describe 'ipv6' do
      let(:ip_addr) { '::ffff:0.255.255.200' }
      let(:ip_addr_out) { '::1:b5e5:21f4:7fc8' }
      let(:ipv6_integer) { IPAddr.new(ip_addr, Socket::AF_INET6).to_i }
      let(:ipv6_integer_out) { IPAddr.new(ip_addr_out, Socket::AF_INET6).to_i }

      it 'returns true if ip is within range from :: (0) to ::ffff:0.255.255.2550 (281470698520575)' do
        expect(extended_class.invalid_ip?(ipv6_integer, ip_addr)).to be_truthy

        expect(included.invalid_ip?(ipv6_integer, ip_addr)).to be_truthy
      end

      it 'returns false if ip is without range from :: (0) to ::ffff:0.255.255.2550 (281470698520575)' do
        expect(extended_class.invalid_ip?(ipv6_integer_out, ip_addr_out)).to be_falsy

        expect(included.invalid_ip?(ipv6_integer_out, ip_addr_out)).to be_falsy
      end
    end
  end

  context '.private_ip?' do
    let(:ip_address) { IPAddr.new('10.0.0.5', Socket::AF_INET).to_i }
    let(:ip_address_out) { IPAddr.new('12.10.0.15', Socket::AF_INET).to_i }

    it 'returns true if ip is within range' do
      expect(extended_class.private_ip?(ip_address)).to be_truthy

      expect(included.private_ip?(ip_address)).to be_truthy
    end

    it 'returns false if ip is without range' do
      expect(extended_class.private_ip?(ip_address_out)).to be_falsy

      expect(included.private_ip?(ip_address_out)).to be_falsy
    end
  end

  context '.ip_exists_in_range?' do
    let(:first_range) { IPAddr.new('10.0.0.5', Socket::AF_INET).to_i }
    let(:last_range) { IPAddr.new('10.0.255.255', Socket::AF_INET).to_i }
    let(:ip_addr) { IPAddr.new('10.0.0.10', Socket::AF_INET).to_i }
    let(:ip_addr_out) { IPAddr.new('12.0.20.20', Socket::AF_INET).to_i }

    it 'returns true if ip is within a range' do
      expect(extended_class.ip_exists_in_range?(first_range, last_range, ip_addr)).to be_truthy

      expect(included.ip_exists_in_range?(first_range, last_range, ip_addr)).to be_truthy
    end

    it 'returns false if ip is without a range' do
      expect(extended_class.ip_exists_in_range?(first_range, last_range, ip_addr_out)).to be_falsy

      expect(included.ip_exists_in_range?(first_range, last_range, ip_addr_out)).to be_falsy
    end
  end

  context '.ip_v4_valid?' do
    let(:valid_ipv4) { '149.0.120.12' }
    let(:invalid_ipv4) { '::1:b5e5:21f4:7fc8' }

    it 'returns true with any valid ipv4 address' do
      expect(extended_class.ip_v4_valid?(valid_ipv4)).to be_truthy

      expect(included.ip_v4_valid?(valid_ipv4)).to be_truthy
    end

    it 'returns false with any invalid ipv4 address' do
      expect(extended_class.ip_v4_valid?(invalid_ipv4)).to be_falsy

      expect(included.ip_v4_valid?(invalid_ipv4)).to be_falsy
    end
  end

  context '.ip_v6_valid?' do
    let(:valid_ipv6) { '::1:b5e5:21f4:7fc8' }
    let(:invalid_ipv6) { '149.0.120.12' }

    it 'returns true with any valid ipv4 address' do
      expect(extended_class.ip_v6_valid?(valid_ipv6)).to be_truthy

      expect(included.ip_v6_valid?(valid_ipv6)).to be_truthy
    end

    it 'returns false with any invalid ipv4 address' do
      expect(extended_class.ip_v6_valid?(invalid_ipv6)).to be_falsy

      expect(included.ip_v6_valid?(invalid_ipv6)).to be_falsy
    end
  end

  context '.ip_to_integer' do
    let(:ip_address) { '113.222.29.10' }
    let(:invalid_ip_address) { '2309230.209.23929.390923' }

    it 'converts ip address to integer' do
      expect(extended_class.ip_to_integer(ip_address)).to be_a(Integer)

      expect(included.ip_to_integer(ip_address)).to be_a(Integer)
    end
  end

  context '.socket_type' do
    let(:ip_v4) { '113.222.29.10' }
    let(:ip_v6) { '::1:b5e5:21f4:7fc8' }

    describe 'ipv4' do
      it 'returns corresponding socket from ip address' do
        expect(extended_class.socket_type(ip_v4)).to be_truthy
        expect(included.socket_type(ip_v4)).to be_truthy
      end
    end

    describe 'ipv6' do
      it 'returns corresponding socket from ip address' do
        expect(extended_class.socket_type(ip_v6)).to be_truthy
        expect(included.socket_type(ip_v6)).to be_truthy
      end
    end
  end
end
