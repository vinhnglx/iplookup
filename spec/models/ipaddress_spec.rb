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
  pending "add some examples to (or delete) #{__FILE__}"
end
