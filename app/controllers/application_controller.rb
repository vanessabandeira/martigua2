class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user_from_token!

  around_filter :log_requests

  def log_requests(&block)
    request_string = "--REQ-- #{Rails.env};#{current_user.try(:id)};#{current_user.try(:email)};#{request.url};#{request.host};#{request.query_string};#{filter_params(params)}"
    begin
      yield
      p "#{request_string} --RESP-- #{response.status};#{response.redirect_url}" unless Rails.env.test?
    rescue Exception => ex
      p "#{request_string} --RESP-- 500;#{ex.message};#{ex.backtrace}" unless Rails.env.test?
      raise
    end
  end

  def filter_params params
    filters = Rails.application.config.filter_parameters
    f = ActionDispatch::Http::ParameterFilter.new filters
    f.filter params
  end

  private
    
    def authenticate_user_from_token!
      user_email = params[:user_email].presence
      user       = user_email && User.find_by_email(user_email)
   
      # Notice how we use Devise.secure_compare to compare the token
      # in the database with the token given in the params, mitigating
      # timing attacks.
      if user && Devise.secure_compare(user.authentication_token, params[:user_token])
        sign_in user, store: false
      end
    end
end
