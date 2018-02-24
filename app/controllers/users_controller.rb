class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_if_not_admin, :only => [:index]
  before_action :set_user, :only => [:edit, :update, :show]

    def edit
    end

    def show
    end

    def index
      @users = User.all
    end

    def update
      @user = User.find(params[:id])
      respond_to do |format|
        if @user.update_attributes(user_params)
          format.html { redirect_to users_path, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end

    def admin_users
      User.all.each do |u|
        if u.admin?
          @users.push(u)
        end
      end
      @users
    end

    def confirmed_users
      User.all.each do |u|
        if u.confirmed?
          @users.push(u)
        end
      end
      @users
    end

    private

    def redirect_if_not_admin
      unless current_user.admin?
        redirect_to new_user_registration_path, notice: 'Only admin can view all users'
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :confirmed)
    end
end
