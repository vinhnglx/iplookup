# IPLookup

[![Circle CI](https://circleci.com/gh/vinhnglx/iplookup.svg?style=svg)](https://circleci.com/gh/vinhnglx/iplookup)

A simple service supply API return country from an IP address.

# How to works

**1. Setup necessary gems and create the database for project:**

```
bundle install
bundle exec rake db:create db:migrate
```

**2. Config your project directory before import:**

- Edit `scripts/import` file - line 51 - `rails_app_home` function

```
rails_app_home () {
  cd /current/project/directory
}
```

- Edit `scripts/cron_import` file - line 4 - `rails_app_home` function

```
rails_app_home () {
  cd /current/project/directory
}
```

**2. Import data:**

```
./scripts/import
```

**3. Run server and enjoy:**

```
bundle exec rails s
```

**4. Run the API:**

```
URL: localhost:3000/ipaddresses
Type: GET
Parameter: ip_addr
```

**5. Set the cronjob:**

```
crontab scripts/cron_import
```

# My Notes

1. The IP address available for free at http://download.ip2location.com/lite/. This service will auto-update the IP address every month.

2. After download, the format of IP address is integer numbers, so here are a few my notes:

3. The Import task will import the IP address from CSV files into the database.

4. The database will have two tables: Ipaddress and Country. The relation between two models: A country will have more IP addresses. An IP address will belong to one country.

5. Each line in CSV files is IP addresses in a range for a country. For example: 16778240 - 16779263 - AU - Australia. So, I think we need to convert the parameter `ip_addr` to integer and check `ip_addr` is available or not in a range.

6. How to convert the IP to integer? How to check the IP address is an IPv4 or IPv6? We can use this [algorithm](http://www.mkyong.com/java/java-convert-ip-address-to-decimal-number/) to converts and some Regexes for detect. But in the Ruby-core, we already have libraries for the tasks:

  - [IPAddr](http://docs.ruby-lang.org/en/2.2.0/IPAddr.html) IPAddr provides a set of methods to manipulate an IP address. Both IPv4 and IPv6 are supported.

  - [Resolv IPv4](http://docs.ruby-lang.org/en/2.2.0/Resolv/IPv4.html) and [Resolv IPv6](http://docs.ruby-lang.org/en/2.2.0/Resolv/IPv6.html) Resolv Ipv4 and Ipv6 will supply regex.

7. I wrote 3 libraries:

  - [Countries](lib/countries.rb) - This library will return country codes and country name. The country code and names will be used in Country model. I downloaded the list of countries from this link: http://data.okfn.org/data/core/country-list

  ```
  # models/country.rb

  validates :code, inclusion: { in: Countries.new.country_codes }
  validates :name, inclusion: { in: Countries.new.country_names }
  ```

  - [IpConverter](lib/ip_converter.rb) - This library will convert the ip address to integer.

  - [IpUtilities](lib/ip_utilities.rb) - This library supply helpful methods.

# TODO

Actually, this service is built in short time, so some parts need to be improved.

- Performance for import task progress.

- The import script needs to refactor.

- Need to refactor the code and write more the test cases.
