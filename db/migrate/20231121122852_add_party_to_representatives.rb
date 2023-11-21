# frozen_string_literal: true

class AddPartyToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :party, :string
    add_column :representatives, :photo_url, :string
    add_column :representatives, :address, :string
  end
end
