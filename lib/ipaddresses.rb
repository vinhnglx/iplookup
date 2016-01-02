require 'csv'

class IpAddress
  attr_reader :csv_file

  # Public: Initialize a new countries object
  #
  # csv_file  - The path to current country csv file
  #
  # Examples
  #
  #   IpAddress.new(/path/to/csv_file)
  #
  # Returns the object
  def initialize(csv_file)
    @csv_file = csv_file
  end

  # Public: List of ip addresses of a country
  #
  # Examples
  #
  #   ip = IpAddress.new(/path/to/csv_file)
  #   ip.show
  #   # => [{ip_address: '[16777216, 16777471]', country_name: 'Australia', country_code: 'AU'}]
  #
  # Returns the array
  def ipaddrs
    begin
      results = []
      CSV.foreach(csv_file) do |row|
        results << {
          ip_address: "[#{row[0]}, #{row[1]}]",
          country_name: row[3],
          country_code: row[2]
        }
      end
      results
    rescue Exception => e
      raise e.to_s
    end
  end
end
