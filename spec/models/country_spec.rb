require 'rails_helper'

RSpec.describe Country, type: :model do
  context 'attributes' do
    it 'has country_code' do
      expect(build(:country, code: 'AU')).to have_attributes(code: 'AU')
    end

    it 'has country_name' do
      expect(build(:country, name: 'Australia')).to have_attributes(name: 'Australia')
    end
  end

  context 'validations' do
    let(:country) { Countries.new }
    let(:country_codes) { country.country_codes }
    let(:country_names) { country.country_names }

    it do
      should validate_inclusion_of(:code).in_array(country_codes)
    end

    it do
      should validate_inclusion_of(:name).in_array(country_names)
    end
  end

  context 'relations' do
    it { should have_many(:ipaddresses) }
  end
end
