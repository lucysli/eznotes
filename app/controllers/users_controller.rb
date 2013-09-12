class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :edit, :update, :show, :destroy]
  before_action :correct_user,    only: [:edit, :update, :show]
  before_action :admin_user,      only: [:create_admin, :destroy, :index]
  before_action :limit_user,      only: [:new_noteuser, :new_notetaker, :create]

  def index
    @users = User.all
  end

  def show
		@user = User.find(params[:id])	
    @notes = @user.notes.paginate(page: params[:page])
	end

  def new_noteuser
    @user = User.new
  end

  def new_notetaker
    @user = User.new(note_taker: true)
  end

  def create
		@user = User.new(create_params)
		if @user.save
      @user.send_new_registration_message
      sign_in @user
      flash[:success] = "Welcome to EZ Notes!"
			redirect_to root_path
		else
      if @user.note_taker
        render 'new_notetaker'
      else
        render 'new_noteuser'
		  end
    end
  end

  def create_admin
    @user = User.new(admin_params)
    @user.admin = true
    if @user.save
      flash[:success] = "New Admin user [ #{@user.student_id} #{@user.name} #{@user.email} created"
      redirect_to :back
    else
      full_msg = " "
      @user.errors.full_messages.each do |msg|
        full_msg = full_msg + msg + ". "
      end
      flash[:error] = "Could not create admin user. #{full_msg}"
      redirect_to :back
    end
  end

  def edit
  end

  def update
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
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin? and current_user?(@user)
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
  		  params.require(:user).permit(:name, :email, :student_id, :note_taker, :approved)
      else
        params.require(:user).permit(:name, :student_id)
      end
  	end 

    def create_params
      params.require(:user).permit(:name, :email, :student_id, :password,
                                   :password_confirmation, :note_taker)
    end

    def admin_params
      params.permit(:name, :email, :student_id, :password,
                                   :password_confirmation, :admin)
    end

    # Before filters

    def correct_user
      if User.exists?(params[:id])
        @user = User.find(params[:id])
        redirect_to root_path, notice: "You are not authorized to access this page." unless current_user?(@user) or current_user.admin?
      else
        if current_user.admin?
          flash[:error] = "User does not exist"
        else
          flash[:notice] = "You are not authorized to access this page."
        end
        redirect_to root_path
      end
    end

    def admin_user
      redirect_to root_path, notice: "You are not authorized to access this page." unless current_user.admin?
    end

    def limit_user
      if signed_in? and not current_user.admin?
        redirect_to root_path, notice: "You are not authorized to perform this action."
      end
    end

end
