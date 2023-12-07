# frozen_string_literal: true

require 'rails_helper'

describe Event do
  describe '#county_names_by_id' do
    it 'returns empty if county or state do not exist' do
      event = described_class.new
      expect(event.county_names_by_id).to eq({})
    end
  end
end
