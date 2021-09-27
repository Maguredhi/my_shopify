class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :find_categories, unless: :backend?
  before_action :set_locale
  helper_method :current_cart

  private

  def record_not_found
    render file: "#{Rails.root}/public/404.html",
           layout: false,
           status: 404
  end

  def backend?
    controller_path.split('/').first == 'Admin'
  end

  def find_categories
    @categories = Category.order(position: :asc)
  end

  def current_cart
    @cart ||= Cart.from_hash(session[:cart_session])
  end

  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end
end
