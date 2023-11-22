# frozen_string_literal: true

Given('Goodwin H. Liu exists') do
  Representative.create!(
    name:      'Goodwin H. Liu',
    ocdid:     'ocd-division/country:us/state:ca',
    title:     'CA State Supreme Court Justice',
    party:     'Nonpartisan',
    address:   '350 McAllister Street, San Francisco, CA, 94102',
    photo_url: 'https://upload.wikimedia.org/wikipedia/commons/2/2c/Default_pfp.svg'
  )
end

When("I visit Goodwin H. Liu's profile page") do
  rep = Representative.find_by(name: 'Goodwin H. Liu')
  visit representative_path(rep)
end

Then("I should see Goodwin H. Liu's name") do
  expect(page).to have_content('Goodwin H. Liu')
end

Then("I should see Goodwin H. Liu's OCD ID") do
  expect(page).to have_content('ocd-division/country:us/state:ca')
end

Then("I should see Goodwin H. Liu's title") do
  expect(page).to have_content('CA State Supreme Court Justice')
end

Then("I should see Goodwin H. Liu's contact address") do
  expect(page).to have_content('350 McAllister Street, San Francisco, CA, 94102')
end

Then("I should see Goodwin H. Liu's political party") do
  expect(page).to have_content('Nonpartisan')
end

Then("I should see Goodwin H. Liu's photo") do
  expect(page).to have_selector('img')
end

When('I visit the representatives search page') do
  visit('/representatives')
end

When('I search with a California address') do
  fill_in('address', with: 'California')
  click_button('Search')
end

When("I click on Goodwin H. Liu's profile in the search results") do
  click_link('Goodwin H. Liu')
end

Then("I should see Goodwin H. Liu's profile") do
  steps %(
    Then I should see Goodwin H. Liu's name
    And I should see Goodwin H. Liu's OCD ID
    And I should see Goodwin H. Liu's title
    And I should see Goodwin H. Liu's contact address
    And I should see Goodwin H. Liu's political party
    And I should see Goodwin H. Liu's photo
  )
end

Given('a news item about Goodwin H. Liu exists') do
  @rep = Representative.find_by(name: 'Goodwin H. Liu')
  NewsItem.create!(
    title:             'News',
    link:              'https://github.com/cs169/fa23-chips-10.5-47',
    description:       'Description',
    representative_id: @rep.id
  )
end

When("I visit Goodwin H. Liu's news items page") do
  visit representative_news_items_path(@rep)
end

When('I click on Info button of the first news item') do
  info_button = find('tbody tr:first-child .btn-info')
  info_button.click
end

When("I click on Goodwin H. Liu's profile in the news item page") do
  click_link('Goodwin H. Liu')
end
