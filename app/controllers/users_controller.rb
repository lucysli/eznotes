class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :edit, :update, :show, :destroy]
  before_action :correct_user,    only: [:edit, :update, :show]
  before_action :admin_user,      only: [:destroy, :index]
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
		@user = User.new(create_params)
		if @user.save
      sign_in @user
      flash[:success] = "Welcome to EZ Notes!"
			redirect_to root_path
		else
			render 'new'
		end
  end

  def edit
  end

  def update
    if @user.authenticate(params[:password])
      if @user.update_attributes(update_params)
        # Handle a successful update
        flash[:success] = "Profile updated"
        if current_user.admin? and not current_user?(@user)
          redirect_to :back
        else
          sign_in @user
          redirect_to root_path
        end
      else
        render 'edit'
      end
    else
      flash.now[:error] = "Invalid password"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin?
      flash[:error] = "Admin User cannot delete themselves!"
      redirect_to user_path(@user)
    else
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    end
  end

  private

    def update_params
      if current_user.admin?
  		  params.require(:user).permit(:name, :email, :student_id, :password,
                                   :password_confirmation, :note_taker)
      else
        params.require(:user).permit(:name, :student_id, :password,
                                   :password_confirmation)
      end
  	end 

    def create_params
      params.require(:user).permit(:name, :email, :student_id, :password,
                                   :password_confirmation, :note_taker)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path, notice: "You are not authorized to access this page." unless current_user?(@user) or current_user.admin?
    end

    def admin_user
      redirect_to root_path, notice: "You are not authorized to access this page." unless current_user.admin?
    end

    def limit_user
      if signed_in?
        redirect_to root_path, notice: "You are not authorized to perform this action."
      end
    end

end
