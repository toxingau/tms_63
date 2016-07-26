class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t "not_authorized"
    redirect_to root_url
  end

  def load_activity user, action_type, target_name
    Activity.create user: user, action_type: action_type,
      target_name: target_name
  end

  private
  def current_ability
    namespace = controller_path.split("/").first
    Ability.new current_user, namespace
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = t "flash.record_not_found", column_name: params[:id]
    redirect_to root_url
  end
end
