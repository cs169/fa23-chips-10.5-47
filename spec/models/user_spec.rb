# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe '#name' do
    it "returns the user's full name" do
      user = described_class.create!(first_name: 'Henry', last_name: 'Chiu', provider: :google_oauth2, uid: '123')
      expect(user.name).to eq('Henry Chiu')
    end
  end

  describe '#auth_provider' do
    context 'when provider is google_oauth2' do
      it 'returns Google' do
        user = described_class.create!(first_name: 'Henry', last_name: 'Chiu', provider: :google_oauth2, uid: '123')
        expect(user.auth_provider).to eq('Google')
      end
    end

    context 'when provider is github' do
      it 'returns Github' do
        user = described_class.create!(first_name: 'Henry', last_name: 'Chiu', provider: :github, uid: '123')
        expect(user.auth_provider).to eq('Github')
      end
    end
  end

  describe '.find_google_user' do
    it 'finds a Google user using a given uid' do
      user = described_class.create!(first_name: 'Henry', last_name: 'Chiu', provider: :google_oauth2, uid: '123')
      found = described_class.find_google_user('123')
      expect(found).to eq(user)
    end
  end

  describe '.find_github_user' do
    it 'finds a Github user using a given uid' do
      user = described_class.create!(first_name: 'Henry', last_name: 'Chiu', provider: :github, uid: '123')
      found = described_class.find_github_user('123')
      expect(found).to eq(user)
    end
  end
end
