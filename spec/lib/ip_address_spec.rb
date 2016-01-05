require 'rails_helper'

RSpec.describe IpAddress do
  let(:ipaddrv4) { IpAddress.new(Rails.root.join('spec', 'fixtures', 'ipaddresses.v4.csv').to_path) }
  let(:ipaddrv6) { IpAddress.new(Rails.root.join('spec', 'fixtures', 'ipaddresses.v6.csv').to_path) }

  let(:ipaddrsv4) do
    [
      { ip_address: '[0, 16777215]', country_name: '-', country_code: '-' },
      { ip_address: '[16777216, 16777471]', country_name: 'Australia', country_code: 'AU' },
      { ip_address: '[16777472, 16778239]', country_name: 'China', country_code: 'CN' }
    ]
  end

  let(:ipaddrsv6) do
    [
      { ip_address: '[0, 281470698520575]', country_name: '-', country_code: '-' },
      { ip_address: '[281470698520576, 281470698520831]', country_name: 'Australia', country_code: 'AU' },
      { ip_address: '[281470698520832, 281470698521599]', country_name: 'China', country_code: 'CN' }
    ]
  end

  context '.ipaddrs' do
    it 'returns ipv4 addresses' do
      expect(ipaddrv4.ipaddrs).to eq ipaddrsv4
    end

    it 'returns ipv6 addresses' do
      expect(ipaddrv6.ipaddrs).to eq ipaddrsv6
    end
  end

  context 'csv path is wrong' do
    let(:path) { Rails.root.join('spec', 'fixtures', 'ip_error.csv').to_path }
    let(:ip) { IpAddress.new(path) }
    let(:error_msg) { "No such file or directory @ rb_sysopen - #{path}" }

    it 'raises an error when call .ipaddrs' do
      expect do
        ip.ipaddrs
      end.to raise_error error_msg
    end
  end
end
