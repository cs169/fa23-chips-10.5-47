# frozen_string_literal: true

require 'rails_helper'

describe County do
  describe '#std_fips_code' do
    it 'returns a formatted FIPS if given a single digit' do
      state = described_class.new(fips_code: 3)
      expect(state.std_fips_code).to eq('003')
    end

    it 'returns a formatted FIPS if given double digits' do
      state = described_class.new(fips_code: 32)
      expect(state.std_fips_code).to eq('032')
    end

    it 'returns a formatted FIPS if given triple digits' do
      state = described_class.new(fips_code: 321)
      expect(state.std_fips_code).to eq('321')
    end
  end
end
