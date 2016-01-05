require 'countries'
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

class Ipaddress < ActiveRecord::Base
  # Validations
  validates :ip_addresses, presence: true

  # Relations
  belongs_to :country

  # Delegate
  delegate :name, to: :country
  delegate :code, to: :country
end
