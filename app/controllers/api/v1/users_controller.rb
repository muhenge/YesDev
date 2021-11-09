class Api::V1::UsersController < ApplicationController
  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { user: @user, message: "Account created successfully!" }. status: :created
    else
      render json: {@user.errors}, status: :unprocessable_entity
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
    render json: {message: ""}, head 204
  end
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
