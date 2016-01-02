require 'csv'
require 'i18n'

class Countries
  attr_reader :csv_file

  # Public: Initialize a new countries object
  #
  # csv_file  - The path to current country csv file
  #
  # Examples
  #
  #   Countries.new(/path/to/csv_file)
  #
  # Returns the object
  def initialize(csv_file = Rails.root.join('lib', 'countries', 'countries.csv').to_path)
    @csv_file = csv_file
  end

  # Public: Show array of country codes
  #
  # Examples
  #
  #   countries = Countries.new(/path/to/csv/file)
  #   countries.country_codes
  #   # => ['AU', 'VN', 'US']
  #
  # Returns the array
  def country_codes
    results = []
    CSV.foreach(csv_file, headers: true) do |row|
      results << row[2]
    end
    results
  end

  # Public: Show array of country names
  #
  # Examples
  #
  #   countries = Countries.new(/path/to/csv/file)
  #   countries.country_names
  #   # => ['Australia', 'Viet Nam', 'United States']
  #
  # Returns the array
  def country_names
    results = []
    CSV.foreach(csv_file, headers: true) do |row|
      results << I18n.transliterate(row[0])
    end
    results
  end
end
