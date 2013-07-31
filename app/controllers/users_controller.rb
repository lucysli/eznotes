class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :edit, :update, :show, :destroy]
  before_action :correct_user,    only: [:edit, :update, :show]
  before_action :admin_user,      only: :destroy
  before_action :limit_user,      only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
		@user = User.find(params[:id])	
    @notes = @user.notes.paginate(page: params[:page])
	end

  def new
    @user = User.new
  end

  def create
		@user = User.new(user_params)
		if @user.save
      sign_in @user
      flash[:success] = "Welcome to EZ Notes!"
			redirect_to @user
		else
			render 'new'
		end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      # Handle a successful update
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin?
      flash[:error] = "Admin User cannot delete himself/herself!"
      redirect_to user_path(@user)
    else
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    end
  end

  private

    def user_params
  		params.require(:user).permit(:name, :email, :student_id)
  	end 

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path, notice: "You are not authorized to access this page." unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def limit_user
      if signed_in?
        redirect_to root_path, notice: "You are not authorized to perform this action."
      end
    end

end
