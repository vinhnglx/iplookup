require 'ipaddresses'

namespace :import do
  desc 'Import the IP addresses'
  task :ipaddrs, [:filename] => :environment do
    # Initial ip object
    ip = IpAddress.new(ENV['FILE']) unless Rails.env == 'test'

    # Can't pass the FILE as argument when test rake task.
    # So, temporary, I'll hard code a csv path.
    ip = IpAddress.new('spec/fixtures/ipaddresses.v4.csv') if Rails.env == 'test'

    # List of ip addresses and countries
    ipaddrs = ip.ipaddrs

    # Create basic progress bar
    progressbar = ProgressBar.create(title: 'IpAddress', starting_at: 0, total: 70000, format: '%a <%B> %p%% %t')

    # Loop ipaddrs to create Country and Ipaddress
    ipaddrs.each do |ipad|
      # Increment progress bar
      progressbar.increment

      # Create country
      country = Country.find_or_create_by(code: ipad[:country_code], name: ipad[:country_name])

      # Create Ipaddress
      Ipaddress.find_or_create_by(ip_addresses: ipad[:ip_address], country_id: country.id)
    end

    puts 'DONE'
  end
end
