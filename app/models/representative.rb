# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    rep_info.officials.flat_map.with_index do |official, index|
      rep_info.offices.select { |office| office.official_indices.include?(index) }
              .map { |office| process_official(official, office) }
    end
  end

  def self.process_official(official, office)
    dict = set_up_attrs
    update_dict(dict, office.name, office.division_id, official.party, official.photo_url)
    dict['address_temp'] = build_address(official.address&.first)

    Representative.find_or_create_by!(
      name:      official.name,
      ocdid:     dict['ocdid_temp'],
      title:     dict['title_temp'],
      party:     dict['party_temp'],
      photo_url: dict['photo_temp'],
      address:   dict['address_temp']
    )
  end

  def self.set_up_attrs
    %w[ocdid_temp title_temp add_temp party_temp photo_temp].each_with_object({}).to_h
  end

  def self.update_dict(dict, name, division_id, party, photo_url)
    dict['title_temp'] = name
    dict['ocdid_temp'] = division_id
    dict['party_temp'] = party
    dict['photo_temp'] = photo_url
  end

  def self.build_address(first_address)
    "#{first_address&.line1}, #{first_address&.city}, #{first_address&.state}, #{first_address&.zip}"
  end
end
