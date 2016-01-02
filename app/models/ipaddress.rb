require 'countries'

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

class Ipaddress < ActiveRecord::Base
  # Validations
  validates :country_code, inclusion: { in: Countries.new.country_codes }
  validates :country_name, inclusion: { in: Countries.new.country_names }
end
