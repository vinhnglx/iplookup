# == Schema Information
#
# Table name: ipaddresses
#
#  id           :integer          not null, primary key
#  ip_addresses :string
#  country_code :string
#  country_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Ipaddress, type: :model do
  context 'attributes' do
    it 'has ip_addresses' do
      expect(build(:ipaddress, ip_addresses: '{option_1: [16843008, 16843263], option_2: [16777216, 16777471]}')).
        to have_attributes(ip_addresses: '{option_1: [16843008, 16843263], option_2: [16777216, 16777471]}')
    end

    it 'has country_code' do
      expect(build(:ipaddress, country_code: 'AU')).to have_attributes(country_code: 'AU')
    end

    it 'has country_name' do
      expect(build(:ipaddress, country_name: 'Australia')).to have_attributes(country_name: 'Australia')
    end
  end

  context 'validations' do
    let(:country) { Countries.new(Rails.root.join('lib', 'countries', 'countries.csv').to_path) }
    let(:country_codes) { country.country_codes }
    let(:country_names) { country.country_names }

    it do
      should validate_inclusion_of(:country_code).in_array(country_codes)
    end

    it do
      should validate_inclusion_of(:country_name).in_array(country_names)
    end
  end
end
