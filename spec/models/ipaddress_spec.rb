# == Schema Information
#
# Table name: ipaddresses
#
#  id           :integer          not null, primary key
#  ip_addresses :string
#  country_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Ipaddress, type: :model do
  context 'attributes' do
    it 'has ip_addresses' do
      ip_address = build(:ipaddress, ip_addresses: '[16843008, 16843263]')
      expect(ip_address).to have_attributes(ip_addresses: '[16843008, 16843263]')
    end
  end

  context 'validations' do
    it { should validate_presence_of :ip_addresses }
  end

  context 'relations' do
    it { should belong_to(:country) }
  end

  context 'delegate' do
    let(:country) { create(:country, name: 'Viet Nam', code: 'VN') }
    let(:ipaddress) { create(:ipaddress, country: country) }

    describe '.name' do
      it 'returns country name' do
        expect(ipaddress.name).to eq 'Viet Nam'
      end
    end

    describe '.code' do
      it 'returns country code' do
        expect(ipaddress.code).to eq 'VN'
      end
    end
  end
end
