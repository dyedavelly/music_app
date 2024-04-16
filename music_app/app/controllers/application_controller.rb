class ApplicationController < ActionController::Base
    skip_forgery_protection

    helper_method :current_user, :logged_in?

    def login(user)
        session[:session_token] = user.reset_session_token!
    end

    def current_user
        current_session_token = session[:session_token]
        @current_user ||= User.find_by(session_token: current_session_token)
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def require_logged_out
        redirect_to users_url if logged_in?
    end

    def logged_in?
        current_user != nil
    end

    def logout!
        if logged_in?
            current_user.reset_session_token!
        end

        session[:session_token] = nil
        @current_user = nil
    end
    
end
