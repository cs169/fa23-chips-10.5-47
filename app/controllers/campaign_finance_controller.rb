# frozen_string_literal: true

class CampaignFinanceController < ApplicationController
  before_action :validate_search_parameters, only: [:search]

  def index; end

  def search
    @top_20_candidates = CampaignFinance.top_20_candidates(@cycle, formatted_category(@category))
    render :search
  end

  def validate_search_parameters
    @cycle = params[:cycle]
    @category = params[:category]

    # unless valid_cycle?(@cycle) && valid_category?(@category)
    return if valid_cycle?(@cycle) && valid_category?(@category)

    flash[:alert] = 'Please select both election cycle and category.'
    redirect_to campaign_finance_index_path and return
  end

  def valid_cycle?(cycle)
    %w[2010 2012 2014 2016 2018 2020].include?(cycle)
  end

  def valid_category?(category)
    [
      'Candidate Loan', 'Contribution Total', 'Debts Owed',
      'Disbursements Total', 'End Cash', 'Individual Total',
      'PAC Total', 'Receipts Total', 'Refund Total'
    ].include?(category)
  end

  def formatted_category(category)
    category.downcase.tr(' ', '-')
  end
end
