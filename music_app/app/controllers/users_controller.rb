class UsersController < ApplicationController

     def new
        render :new
     end

     def create
        @user = User.new(user_params)
        if @user.save
           redirect_to user_url(@user)
        else
            render json: @user.errors.full_messages, status: 422
        end
     end

     def show
        @user = User.find(params[:id])
        #render json: @user
     end

     def user_params
        params.require(:user).permit(:email, :password)
     end
end