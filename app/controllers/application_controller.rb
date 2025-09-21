class ApplicationController < ActionController::Base
  include Authentication
  include ActiveStorage::SetCurrent

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_i18n_locale_from_params

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:alert] = "#{params[:locale]} translation is not available!"
        logger.error flash.now[:alert]
      end
    end
  end
end
