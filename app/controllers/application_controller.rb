class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale_from_params
  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisé à réaliser cette action."
    redirect_to(root_path)
  end

  def default_url_options
    { host: ENV['DOMAIN'] || 'localhost:3000', locale: I18n.locale }
  end

  protected

  def set_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "La traduction en #{params[:locale]} n'est pas disponible"
      end
    else
      I18n.locale = I18n.default_locale
    end
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
