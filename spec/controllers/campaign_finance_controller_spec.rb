# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinanceController, type: :controller do
  shared_examples 'a validation method' do |method, valid_input, invalid_input|
    it "returns true for valid input (#{valid_input})" do
      expect(controller.send(method, valid_input)).to be true
    end

    it "returns false for invalid input (#{invalid_input})" do
      expect(controller.send(method, invalid_input)).to be false
    end
  end

  describe 'Private methods' do
    describe '#valid_cycle?' do
      it_behaves_like 'a validation method', :valid_cycle?, '2020', '1999'
    end

    describe '#valid_category?' do
      it_behaves_like 'a validation method', :valid_category?, 'Contribution Total', 'Invalid Category'
    end
  end

  describe '#formatted_category' do
    it 'formats the category correctly' do
      expect(controller.send(:formatted_category, 'Contribution Total')).to eq('contribution-total')
    end
  end
end
