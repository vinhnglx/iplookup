require 'csv'

namespace :import do
  desc 'Import the IP addresses'
  task :ipaddrs, [:filename] => :environment do

    # Can't pass the FILE as argument when test rake task.
    # So, temporary, I'll hard code a csv path.
    ENV['FILE'] = 'spec/fixtures/ipaddresses.v4.csv' if Rails.env == 'test'

    # Create basic progress bar
    progressbar = ProgressBar.create(title: 'IpAddress', starting_at: 0, total: CSV.foreach(ENV['FILE']).count, format: '%a <%B> %p%% %t')

    # Loop ipaddrs to create Country and Ipaddress
    CSV.foreach(ENV['FILE']) do |row|
      # Increment progress bar
      progressbar.increment

      created_at = Time.zone.now.strftime('%Y-%m-%d %H:%M:%S')
      name = row[3]
      code = row[2]
      ip_address = "[#{row[0]}, #{row[1]}]"

      # Create country
      country = Country.find_or_create_by(name: name, code: code)

      # Create ip address
      Ipaddress.find_or_create_by(ip_addresses: ip_address, country_id: country.id)
    end

    puts 'DONE'
  end
end
