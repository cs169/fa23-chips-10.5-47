# frozen_string_literal: true

require 'rails_helper'

describe MyNewsItemsController do
  let(:representative) do
    Representative.create!(title: 'Office_1', ocdid: 'ocd-division-id_1', name: 'Sam', party: 'Independent',
                           photo_url: 'example.com/photo', address: '2067 University Ave, Berkeley, CA, 94704')
  end
  let(:news_item) do
    NewsItem.create!(title: 'News', link: 'https://github.com/cs169/fa23-chips-10.5-47', description: 'Description',
                     representative_id: representative.id)
  end
  let(:user) { User.create!(first_name: 'Henry', last_name: 'Chiu', provider: :google_oauth2, uid: '123') }

  before do
    session[:current_user_id] = user.id
  end

  describe 'GET #new' do
    it 'assigns a new news_item' do
      get :new, params: { representative_id: representative.id }
      expect(assigns(:news_item)).to be_a_new(NewsItem)
    end
  end

  describe 'GET #edit' do
    it 'assigns the given news_item' do
      get :edit, params: { id: news_item.id, representative_id: representative.id }
      expect(assigns(:news_item)).to eq(news_item)
    end
  end

  describe 'POST #create' do
    it 'creates a new NewsItem' do
      expect do
        post :create, params: { news_item: { title: 'News', link: 'https://github.com/cs169/fa23-chips-10.5-47',
        description: 'Description', representative_id: representative.id }, representative_id: representative.id }
      end.to change(NewsItem, :count).by(1)
    end
  end

  describe 'PATCH #update' do
    let(:request) do
      patch :update, params: {
        id:                news_item.id,
        news_item:         { title: 'New Title' },
        representative_id: representative.id
      }
    end

    it 'updates the given news_item' do
      request
      news_item.reload
      expect(news_item.title).to eq('New Title')
    end
  end
end
