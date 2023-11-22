# frozen_string_literal: true

Given(/the following states exist/) do |states_table|
  states_table.hashes.each do |state|
    State.create!(name:         state['name'],
                  symbol:       state['symbol'],
                  lat_min:      state['lat_min'],
                  lat_max:      state['lat_max'],
                  long_min:     state['long_min'],
                  long_max:     state['long_max'],
                  fips_code:    state['fips_code'],
                  is_territory: state['is_territory'])
  end
end

Given(/the following counties in (.*) exist/) do |state_name, counties_table|
  state = State.find_by(name: state_name)
  counties_table.hashes.each do |county|
    state.counties.create!(name:       county['name'],
                           fips_class: county['fips_class'],
                           fips_code:  county['fips_code'])
  end
end

Given("I'm on the California page") do
  visit '/state/CA'
end

When('I click Alameda County') do
  click_link('View', match: :first)
end

Then("I should see Henry C. Levy's name") do
  expect(page).to have_content('Henry C. Levy')
end
