class Api::V1::UsersController < ApplicationController
  before_action :check_owner, only: %i[update destroy]
  def index
    @users = User.all
    render json: { users: @users }, status: :ok
  end
  
  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { user: @user, message: "Account created successfully!" }, status: :created
    else
      render json: {user:@user.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: { user: @user, message: "Profile updated successfully" }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  def destroy
    @user.destroy
    head 204
  end
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end
end
