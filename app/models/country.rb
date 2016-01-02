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

class Country < ActiveRecord::Base
  # Validations
  validates :code, inclusion: { in: Countries.new.country_codes }
  validates :name, inclusion: { in: Countries.new.country_names }

  # Relations
  has_many :ipaddresses
end
