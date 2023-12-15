# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def signed_in_user; end
end
