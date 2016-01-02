require 'rails_helper'

RSpec.describe Countries do
  let(:countries) { Countries.new(Rails.root.join('spec', 'fixtures', 'countries.csv').to_path) }
  let(:country_codes) { ['AF', 'AL', 'DZ', 'AS', 'AD', 'AO', 'AI'] }
  let(:country_names) { ['Afghanistan', 'Albania', 'Algeria', 'American Samoa', 'Andorra', 'Angola', 'Anguilla'] }

  it 'returns country_codes' do
    expect(countries.country_codes).to eq country_codes
  end

  it 'returns country_names' do
    expect(countries.country_names).to eq country_names
  end
end
