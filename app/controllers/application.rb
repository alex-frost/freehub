# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '4053cfc52c7349828c17880e0b762667'

  # Include restful_authentication support
  include AuthenticatedSystem

  # Authenticate
  before_filter :login_from_cookie, :login_required, :store_current_user

  # Root object for nested resources
  before_filter :resolve_organization

  private

  def resolve_organization
    @organization = Organization.find_by_key(params[:organization_key]) if params[:organization_key]
  end

  def store_current_user
    User.current_user = current_user
  end

end
