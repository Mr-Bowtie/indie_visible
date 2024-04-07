# frozen_string_literal: true

require 'logging/logs'

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Logging::Logs
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

  def after_invite_path_for(_inviter, _invitee)
    admin_root_path
  end

  def require_admin
    redirect_to new_user_session_path unless current_user && curent_user.at_least_admin?
  end
end
