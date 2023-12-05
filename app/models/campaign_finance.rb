# frozen_string_literal: true

require 'faraday'
require 'json'

class CampaignFinance < ApplicationRecord
  API_KEY = '9lcjslvwVjbqtX0KcQQ3W9rFm316caQQ2T89n4xA'
  BASE_URL = 'https://api.propublica.org/campaign-finance/v1/'

  def self.top_20_candidates(cycle, category)
    response = make_api_request(cycle, category)
    candidates = extract_candidates(response)
    log_category(category)
    candidates.take(20)
  end

  def self.make_api_request(cycle, category)
    Faraday.new(url: BASE_URL) do |faraday|
      faraday.headers['X-API-Key'] = API_KEY
      faraday.adapter Faraday.default_adapter
    end.get("#{cycle}/candidates/leaders/#{category}.json")
  end

  def self.extract_candidates(response)
    return [] unless response.success?

    JSON.parse(response.body)['results'] || []
  end

  def self.log_category(category)
    Rails.logger.info("Fetched top 20 candidates for category: #{category}")
  end
end
