require 'rails_helper'

describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    it 'does not create a duplicate entry for an existing representative' do
      # Mock representative information from the API
      Representative.create!(title: 'Office_1', ocdid: 'ocd-division-id_1', name: 'Sam', party: 'Independent', photo_url: 'example.com/photo', address: '2067 University Ave, Berkeley, CA, 94704')
      rep_info = double(officials: [double(name: 'Sam', party: 'Independent', photo_url: 'example.com/photo', address: [double(line1: '2067 University Ave', city: 'Berkeley', state: 'CA', zip: '94704')])],
                       offices: [double(name: 'Office_1', division_id: 'ocd-division-id_1', official_indices: [0])])

      # Ensure the method creates a representative and stores it in the database
      Representative.civic_api_to_representative_params(rep_info)
      expect(Representative.count).to eq(1)
    end
  end
end