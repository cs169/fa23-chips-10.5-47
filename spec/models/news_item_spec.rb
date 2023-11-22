# frozen_string_literal: true

require 'rails_helper'

describe NewsItem do
  describe '.find_for' do
    let(:representative) do
      Representative.create!(title: 'Office_1', ocdid: 'ocd-division-id_1', name: 'Sam', party: 'Independent',
                             photo_url: 'example.com/photo', address: '2067 University Ave, Berkeley, CA, 94704')
    end
    let!(:news_item) do
      described_class.create!(title: 'News', link: 'https://github.com/cs169/fa23-chips-10.5-47', description:
                             'Description', representative_id: representative.id)
    end

    it 'returns the correct news item for a given representative' do
      expect(described_class.find_for(representative.id)).to eq(news_item)
    end
  end
end
