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

FactoryGirl.define do
  factory :ipaddress do
    ip_addresses '{option_1: [16843008, 16843263], option_2: [16777216, 16777471]}'
    country_code 'AU'
    country_name 'Australia'
  end
end
