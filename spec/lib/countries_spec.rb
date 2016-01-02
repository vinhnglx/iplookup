require 'rails_helper'

RSpec.describe Countries do
  let(:countries) { Countries.new(Rails.root.join('spec', 'fixtures', 'countries.csv').to_path) }
  let(:country_codes) { ['AF', 'AL', 'DZ', 'AS', 'AD', 'AO', 'AI', '-'] }
  let(:country_names) { ['Afghanistan', 'Albania', 'Algeria', 'American Samoa', 'Andorra', 'Angola', 'Anguilla', '-'] }

  context '.country_codes' do
    it 'returns country_codes' do
      expect(countries.country_codes).to eq country_codes
    end
  end

  context '.country_names' do
    it 'returns country_names' do
      expect(countries.country_names).to eq country_names
    end
  end

  context 'csv path is wrong' do
    let(:path) { Rails.root.join('spec', 'fixtures', 'countries_error.csv').to_path }
    let(:countries) { Countries.new(path) }
    let(:error_msg) { "No such file or directory @ rb_sysopen - #{path}" }

    it 'raises an error when call .country_codes' do
      expect do
        countries.country_codes
      end.to raise_error error_msg
    end

    it 'raises an error when call .country_names' do
      expect do
        countries.country_names
      end.to raise_error error_msg
    end
  end
end
