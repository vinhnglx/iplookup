class CreateIpaddresses < ActiveRecord::Migration
  def change
    create_table :ipaddresses do |t|
      t.string :ip_addresses
      t.string :country_code
      t.string :country_name

      t.timestamps null: false
    end
  end
end
