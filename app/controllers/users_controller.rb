class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
 # before_action :admin_user,     only: :destroy

  include UserGroupsHelper

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user=User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user=User.new(user_params)
    @user.level=0
    @user.user_group_id=common_user_group.id
    @user.header=get_pic_str(params[:user][:header])

    if @user.save
      log_in @user
      flash[:info] = I18n.t('my.notice.sign_up_success')
      redirect_to root_url
    else
      render 'new'
    end
  end


  def update

    params[:user][:header]=get_pic_str(params[:user][:header])
    if @user.update_attributes(user_params)
      flash[:success] = t('my.notice.update_success')
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = I18n.t('my.notice.remove_success')
    redirect_to users_url
  end

  def edit
  end

  private

    def user_params
      params.require(:user).permit(:name, :nick_name,
                                   :password, :password_confirmation,
                                    :header)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
