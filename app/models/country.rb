class Country < ActiveRecord::Base
  # Validations
  validates :code, inclusion: { in: Countries.new.country_codes }
  validates :name, inclusion: { in: Countries.new.country_names }

  # Relations
  has_many :ipaddresses
end
