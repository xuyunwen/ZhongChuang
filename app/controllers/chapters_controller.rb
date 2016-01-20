class ChaptersController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]

  def index
  end

  def new
    @novel=Novel.find(params[:novel])
    @chapter=Chapter.new
    @chapter.novel_id=@novel.id
    @chapter.number=@novel.new_chapter_num(current_user)
    has_manage_novel_permission
  end

  def show
    @chapter=Chapter.find(params[:id])
  end

  def create
    @novel=Novel.find(params[:novel_id])
    @chapter=Chapter.new
    user= ( has_manage_novel_permission and !params[:author_name].blank?) ? User.find_by_user_name([:author_name]) : current_user
    params[:chapter][:number]=@novel.new_chapter_num(user)
    params[:chapter][:author_id]=user.id
    params[:chapter][:novel_id]=@novel.id
    unless has_manage_novel_permission
      params[:chapter][:status]=Chapter::Status::ACTIVE
    end
    if @chapter.update_attributes(chapter_params)
      flash[:success] = t('my.notice.add_success')
      redirect_to @novel
    else
      render 'new'
    end

  end

  def destroy
  end

  def update
  end

  def edit
  end

  def has_manage_novel_permission
    @has_manage_novel_permission||=current_user.has_permission?(Permission::MANAGE_NOVELS)
  end

  def chapter_params
    params.require(:chapter).permit(:novel_id, :number, :author_id,
                                    :status, :cite_id, :title, :content,
                                    :summary, :subsequent_summary, :foreshadowing)
  end

end
