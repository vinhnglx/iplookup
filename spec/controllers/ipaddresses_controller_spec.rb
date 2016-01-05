require 'rails_helper'

RSpec.describe IpaddressesController, type: :controller do
  context 'index' do
    describe 'format ip invalid' do
      it 'returns status bad_request' do
        get :index, ip_addr: '2309230.209.23929.390923'
        expect(response.status).to eq 400
        expect(JSON.parse(response.body)['error_message']).to eq 'The format of your IP address does not valid!!!'
      end
    end

    describe 'invalid ip address' do
      it 'return invalid ip address message' do
        get :index, ip_addr: '0.0.0.0'
        expect(JSON.parse(response.body)['error_message']).to eq 'Invalid IP address.'
      end
    end

    describe 'private ip address' do
      it 'returns invalid ip address message' do
        get :index, ip_addr: '10.0.0.5'
        expect(JSON.parse(response.body)['error_message']).to eq 'Private IP address.'
      end
    end

    describe 'IP address' do
      let!(:country) { create(:country, name: 'Viet Nam', code: 'VN') }
      let!(:ip_address) { create(:ipaddress, ip_addresses: '[16843008, 16843263]', country: country) }

      it 'returns the country the IP address' do
        get :index, ip_addr: '1.1.1.1'
        res = JSON.parse(response.body)

        expect(res['country']).to eq 'Viet Nam'
        expect(res['code']).to eq 'VN'
      end

      it 'returns the ip not available, e.g: 127.0.0.1' do
        get :index, ip_addr: '127.0.0.1'
        res = JSON.parse(response.body)

        expect(res['error_message']).to eq 'The IP is not available'
      end
    end
  end
end
