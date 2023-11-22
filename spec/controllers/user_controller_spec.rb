# frozen_string_literal: true

require 'rails_helper'

describe UserController do
  describe 'GET #profile' do
    let(:user) { User.create!(first_name: 'Henry', last_name: 'Chiu', provider: :google_oauth2, uid: '123') }

    before do
      session[:current_user_id] = user.id
    end

    it 'assigns the user to @user' do
      get :profile
      expect(assigns(:user)).to eq(user)
    end
  end
end
