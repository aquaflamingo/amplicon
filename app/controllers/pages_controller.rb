# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :require_login

  def index; end
  def terms_of_service;
    render 'terms'
  end
  def privacy_policy
    render 'privacy'
  end
end
