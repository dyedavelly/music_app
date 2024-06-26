class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        email = params[:user][:email]
        password = params[:user][:password]

        @user = User.find_by_credentials(email,password)

        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            render :new
        end
    end

    def destroy
        logout!
        # flash[:messages] = ["Successfully logged out"]
        redirect_to new_session_url
    end
end