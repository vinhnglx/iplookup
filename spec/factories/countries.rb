# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :country do
    code 'AU'
    name 'Australia'
  end
end
