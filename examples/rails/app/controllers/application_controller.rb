# encoding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery
  skip_before_filter :verify_authenticity_token, :if => :logout_request?

  before_filter :sso_filter

  protected

  def logout_request?
    CASClient::Request.logout_request?(request)
  end

  def sso_filter
    CASClient::Frameworks::Rails::Filter.filter(self)
  end

  def gateway_filter
    CASClient::Frameworks::Rails::GatewayFilter.filter(self)
  end
end
