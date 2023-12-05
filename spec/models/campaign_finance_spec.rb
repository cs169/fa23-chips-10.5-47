# frozen_string_literal: true

require 'rails_helper'
require 'faraday'
require 'json'

RSpec.describe CampaignFinance, type: :model do
  let(:cycle) { '2020' }
  let(:category) { 'president' }

  describe '.top_20_candidates' do
    let(:mock_response) do
      instance_double(Faraday::Response, success?: true, body: mock_response_body)
    end
    let(:mock_response_body) do
      { results: Array.new(25, { name: 'Candidate', party: 'Party', total: 1000 }) }.to_json
    end

    before do
      allow(described_class).to receive(:make_api_request).and_return(mock_response)
      allow(Rails.logger).to receive(:info) # Setting Rails.logger as a spy
    end

    it 'returns 20 candidates' do
      candidates = described_class.top_20_candidates(cycle, category)
      expect(candidates.size).to eq(20)
    end

    it 'logs the category' do
      described_class.top_20_candidates(cycle, category)
      expect(Rails.logger).to have_received(:info).with("Fetched top 20 candidates for category: #{category}")
    end
  end

  describe '.make_api_request' do
    let(:stubbed_connection) do
      Faraday.new do |builder|
        builder.adapter :test do |stub|
          stub.get("#{cycle}/candidates/leaders/#{category}.json") { [200, {}, {}.to_json] }
        end
      end
    end

    before do
      allow(Faraday).to receive(:new).and_return(stubbed_connection)
    end

    it 'makes a GET request to the correct URL' do
      response = described_class.make_api_request(cycle, category)
      expect(response).to be_a(Faraday::Response)
    end
  end

  describe '.extract_candidates' do
    let(:success_response) { instance_double(Faraday::Response, success?: true, body: success_body) }
    let(:failure_response) { instance_double(Faraday::Response, success?: false) }
    let(:success_body) do
      { results: [{ name: 'Candidate A', party: 'Party A', total: 2000 }] }.to_json
    end

    it 'extracts candidates from a successful response' do
      candidates = described_class.extract_candidates(success_response)
      expect(candidates).to be_an(Array)
      expect(candidates.first).to include('name' => 'Candidate A', 'party' => 'Party A', 'total' => 2000)
    end

    it 'returns an empty array for a failed response' do
      candidates = described_class.extract_candidates(failure_response)
      expect(candidates).to be_empty
    end
  end
end
