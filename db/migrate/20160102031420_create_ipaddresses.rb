class CreateIpaddresses < ActiveRecord::Migration
  def change
    create_table :ipaddresses do |t|
      t.string :ip_addresses
      t.integer :country_id

      t.timestamps null: false
    end
  end
end
