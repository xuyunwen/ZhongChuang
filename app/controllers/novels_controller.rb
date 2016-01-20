class NovelsController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action 'has_permission(Permission::MANAGE_NOVELS)', only: [:edit, :update, :destroy]

  def index
    @novels=Novel.all
  end

  def new
    @novel=Novel.new
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
    convert_cover_data
    @novel = Novel.find(params[:id])
    if @novel.update_attributes(novel_params)
      flash[:success] = t('my.notice.update_success')
      redirect_to @novel
    else
      render 'edit'
    end
  end

  def edit
    @novel=Novel.find(params[:id])
  end

  def novel_params
    params.require(:novel).permit(:name, :cover, :category_id, :status, :description)
  end


  def convert_cover_data
    header_data=get_pic_str(params[:novel][:cover])
    params[:novel][:cover]=header_data
  end
end
