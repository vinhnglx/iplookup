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
      name = ActiveRecord::Base.connection.quote(row[3])
      code = ActiveRecord::Base.connection.quote(row[2])
      ip_address = ActiveRecord::Base.connection.quote("[#{row[0]}, #{row[1]}]")

      # Create country
      country_count = "select count(*) from countries where name = #{name} and code = #{code}"
      if ActiveRecord::Base.connection.execute(country_count).first['count(*)'] == 0
        country_sql = "INSERT INTO countries (name, code, created_at, updated_at) VALUES (#{name}, #{code}, '#{created_at}', '#{created_at}')"
        country = ActiveRecord::Base.connection.execute(country_sql)
        country_id = ActiveRecord::Base.connection.last_inserted_id(country)
      end

      ip_count = "select count(*) from ipaddresses where ip_addresses = #{ip_address} and country_id = '#{country_id}'"
      if ActiveRecord::Base.connection.execute(ip_count).first['count(*)'] == 0
        ip_sql = "INSERT INTO ipaddresses (ip_addresses, country_id, created_at, updated_at) VALUES (#{ip_address}, '#{country_id}', '#{created_at}', '#{created_at}')"
        ActiveRecord::Base.connection.execute(ip_sql)
      end
    end

    puts 'DONE'
  end
end
