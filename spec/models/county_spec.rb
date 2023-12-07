# frozen_string_literal: true

require 'rails_helper'

describe County, type: :model do
  describe '#std_fips_code' do
    it 'returns a FIPS from a single digit' do
      state = described_class.new(fips_code: 1)
      expect(state.std_fips_code).to eq('001')
    end

    it 'returns a FIPS from double digits' do
      state = described_class.new(fips_code: 12)
      expect(state.std_fips_code).to eq('012')
    end

    it 'returns a FIPS from triple digits' do
      state = described_class.new(fips_code: 123)
      expect(state.std_fips_code).to eq('123')
    end
  end
end
