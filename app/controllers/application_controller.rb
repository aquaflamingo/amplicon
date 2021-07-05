# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller

  add_flash_types :success, :warning, :danger, :info
end
