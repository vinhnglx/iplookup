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

  context 'relations' do
    it { should belong_to(:country) }
  end
end
