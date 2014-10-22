class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create, :index]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def new
    @user = User.new
    # @user.addresses << Address.new
    # @address = Address.new 
    3.times {@user.addresses.build}
    # @user.addresses << Address.first.update(:user_id)
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.includes(:posts)
  end

  def edit
    @user = User.find(params[:id])
    @user.addresses.build
  end

  def create
    @user = User.new(whitelisted_user_params)
    # asdf
    if @user.save
      sign_in(@user)
      flash[:success] = "Created new user!"
      redirect_to @user
    else
      flash.now[:error] = "Failed to Create User!"
      render :new
    end
  end

  # def create
  #   @user = User.new(whitelisted_user_params)
  #   addresses = whitelisted_address_params[:addresses]
  #   addresses.each do |address_attributes|
  #     @user.addresses.build(address_attributes)
  #   end
  #   if @user.save
  #     flash[:success] = "Totally just saved your account and address(es)"
  #     redirect_to @user
  #   else
  #     flash.now[:error] = "Failed to save due to #{@user.errors.full_messages.inspect}"
  #     render :new
  #   end
  # end

  def update
    @user = User.find(params[:id])
    # asdf
    if @user.update(whitelisted_user_params)
      flash[:success] = "Updated your account!"
      redirect_to @user
    else
      flash.now[:error] = "Failed to update your account!"
      render :edit
    end
  end

  private
  # def whitelisted_user_params
  #   params.
  #     require(:user).
  #     permit( :name,
  #             :email,
  #             { :addresses => [ :street_address,
  #                               :city,
  #                               :state,
  #                               :zip]})
  # end
  def whitelisted_user_params
    params.
      require(:user).
      permit( :name,
              :email,
              :password,
              :password_confirmation,
              :billing_address_id,
              :avatar,
              :delete_avatar,
              { :addresses_attributes => [
                  :street_address,
                  :city,
                  :state,
                  :zip,
                  :id,
                  :_destroy] } )
  end
  def whitelisted_address_params
    params.
      permit( :addresses => [ :street_address,
                              :city,
                              :state,
                              :zip])
  end
    #params.require(:user).permit( :name,:email,{ :addresses_attributes => [:street_address,:city,:state,:zip] } )
end
