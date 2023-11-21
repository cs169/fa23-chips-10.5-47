# frozen_string_literal: true

require 'rails_helper'

describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    described_class.create!(title: 'Office_1', ocdid: 'ocd-division-id_1', name: 'Sam', party: 'Independent',
                            photo_url: 'example.com/photo', address: '2067 University Ave, Berkeley, CA, 94704')
    rep_info = OpenStruct.new(officials: [OpenStruct.new(name: 'Sam', party: 'Independent', photo_url:
                                                        'example.com/photo', address: [OpenStruct.new(line1:
                                                        '2067 University Ave', city: 'Berkeley', state: 'CA', zip:
                                                        '94704')])],
                              offices:   [OpenStruct.new(name: 'Office_1', division_id: 'ocd-division-id_1',
                                                         official_indices: [0])])

    it 'does not create a duplicate entry for an existing representative' do
      described_class.civic_api_to_representative_params(rep_info)
      expect(described_class.count).to eq(1)
    end
  end
end
