class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :find_categories, unless: :backend?
  before_action :set_locale
  before_action :set_ransack
  helper_method :current_cart
  helper_method :local_datetime
  helper_method :find_sku

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

  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def set_ransack
    @q = Product.ransack(params[:q])
  end

  def current_cart
    @cart ||= Cart.from_hash(session[:cart_session])
  end

  def local_datetime(updated_at)
    updated_at.localtime.strftime("%Y-%m-%d %H:%M")
  end

  def find_sku(sku_id)
    Sku.find(sku_id)
  end
end
