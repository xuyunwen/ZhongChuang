class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  include I18n
  include SessionsHelper
  include UsersHelper

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = '请登录!'
      redirect_to login_url
    end
  end

  require 'base64'

  # 从上传的文件流中获取编码的图片数据
  def get_pic_str(stream)
    return nil unless stream
    data=stream.read
    pic_str='data:image/png;base64,'
    pic_str << Base64.encode64(data)
    return pic_str
  end

end
