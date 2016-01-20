class NovelsController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action 'has_permission(Permission::MANAGE_NOVELS)', only: [:edit, :update, :destroy]

  def index
    @novels=Novel.all
  end

  def new
  end

  def show
    @novel=Novel.find(params[:id])
  end

  def create
  end

  def destroy
    Novel.find(params[:id]).destroy
    flash[:success] = I18n.t('my.notice.remove_success')
    redirect_to novels_path
  end

  def update
  end

  def edit
  end


end
