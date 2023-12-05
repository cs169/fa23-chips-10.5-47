# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinanceController, type: :controller do
  describe 'Private methods' do
    describe '#valid_cycle?' do
      it 'returns true for a valid cycle' do
        expect(controller.send(:valid_cycle?, '2020')).to be true
      end

      it 'returns false for an invalid cycle' do
        expect(controller.send(:valid_cycle?, '1999')).to be false
      end
    end

    describe '#valid_category?' do
      it 'returns true for a valid category' do
        expect(controller.send(:valid_category?, 'Contribution Total')).to be true
      end

      it 'returns false for an invalid category' do
        expect(controller.send(:valid_category?, 'Invalid Category')).to be false
      end
    end

    describe '#formatted_category' do
      it 'formats the category correctly' do
        expect(controller.send(:formatted_category, 'Contribution Total')).to eq('contribution-total')
      end
    end
  end
end
