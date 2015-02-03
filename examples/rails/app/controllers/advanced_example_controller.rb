# A more advanced example.
# For basic usage see the SimpleExampleController.
class AdvancedExampleController < ApplicationController
  # This will allow the user to view the index page without authentication
  # but will process CAS authentication data if the user already
  # has an SSO session open.
  before_filter :gateway_filter, :only => :index

  # This requires the user to be authenticated for viewing all other pages.
  skip_before_filter :sso_filter, :only => :index

  def index
    @username = session[:cas_user]

    @login_url = CASClient::Frameworks::Rails::Filter.login_url(self)
  end

  def my_account
    @username = session[:cas_user]

    # Additional user attributes are available if your
    # CAS server is configured to provide them.
    # See http://code.google.com/p/rubycas-server/wiki/HowToSendExtraUserAttributes
    @extra_attributes = session[:cas_extra_attributes]
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
