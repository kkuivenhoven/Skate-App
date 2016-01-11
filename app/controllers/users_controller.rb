#Sources:
#https://www.railstutorial.org/book, Hartl Michael, 2014
#https://github.com/mislav/will_paginate

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
 
  def index
    #@users = User.where(activated: true). paginate(page: params[:page], :per_page => 20)
    @users = User.where(activated: true). paginate(page: params[:page], :per_page => 20).order('name')
    #if params[:search]
    #  render 'search_results'
    #else
    #  @users = User.where(activated: true). paginate(page: params[:page], :per_page => 20).order('name')
      #@users = User.order("created_at DESC")
    #end
  end
  
  #def search_results
  #  @users = User.search(params[:search]).order("created_at DESC")
  #end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    hate_filter = LanguageFilter::Filter.new matchlist: :hate, replacement: :garbled
    prof_filter = LanguageFilter::Filter.new matchlist: :profanity, replacement: :garbled 
    sex_filter = LanguageFilter::Filter.new matchlist: :sex, replacement: :garbled 
    viol_filter = LanguageFilter::Filter.new matchlist: :violence, replacement: :garbled 
    if hate_filter.match?(@user.name) or prof_filter.match?(@user.name) or sex_filter.match?(@user.name) or viol_filter.match?(@user.name)
      flash[:warning] = "Please pick a more appropriate user name."
      render 'new'
    elsif @user.save
       @user.send_activation_email
       flash[:info] = "Please check your email to activate your account."
       redirect_to root_url
    else
       render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy #method chaining combines find & destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private
 
    def user_params 
      params.require(:user).permit(:name, :email, :password, :password_confirmation    )
    end

    #confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
  
    #confirms an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
