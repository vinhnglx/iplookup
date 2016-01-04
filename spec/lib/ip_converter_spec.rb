require 'rails_helper'

RSpec.describe IpConverter do
  context '.to_integer' do
    let(:ipv4) { '116.110.96.61' }
    let(:ipv6) { 'ff02::1' }
    let(:wrong_ipv4) { '12.12.21.2019' }
    let(:wrong_ipv6) { 'ff02::138:::3' }
    let(:error_msg_v4) { 'invalid address' }
    let(:error_msg_v6) { 'address family mismatch' }

    it 'converts an ip address to integer' do
      expect(IpConverter.new(ipv4, Socket::AF_INET).to_integer).to be_a_kind_of(Integer)
      expect(IpConverter.new(ipv6, Socket::AF_INET6).to_integer).to be_a_kind_of(Integer)
    end

    it 'raises an error when pass wrong ip address' do
      expect do
        IpConverter.new(wrong_ipv4, Socket::AF_INET).to_integer
      end.to raise_error error_msg_v4

      expect do
        IpConverter.new(wrong_ipv6, Socket::AF_INET).to_integer
      end.to raise_error error_msg_v6
    end
  end
end
