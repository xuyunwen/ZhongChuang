class ChaptersController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]

  def new
    unless params[:cite_id].blank?
      @chapter=Chapter.find(params[:cite_id]).dup
      @chapter.author_id=nil
      @chapter.cite_id=params[:cite_id]
      @chapter.id=nil
      params[:novel]=@chapter.novel_id
    else
      @chapter=Chapter.new
    end
    @novel=Novel.find(params[:novel])
    @chapter.novel_id=@novel.id
    @chapter.number=@novel.new_chapter_num(current_user)
    has_manage_novel_permission
  end

  def show
    @chapter=Chapter.find(params[:id])
  end

  def create
    cite_id=params[:cite_id]
    @novel=Novel.find(params[:novel_id])
    @chapter=Chapter.new
    user= ( has_manage_novel_permission and !params[:author_name].blank?) ? User.find_by_user_name([:author_name]) : current_user
    params[:chapter][:number]=@novel.new_chapter_num(user)
    params[:chapter][:author_id]=user.id
    params[:chapter][:novel_id]=@novel.id
    params[:chapter][:cite_id]=cite_id
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
    chapter=Chapter.find(params[:id])
    if has_manage_novel_permission or chapter.author.id = current_user.id
      novel=Novel.find(chapter.novel_id)
      if chapter.destroy
        flash[:notice]='删除成功'
        redirect_to novel
      else
        render 'show'
      end
    end
  end

  def update
    @chapter = Chapter.find(params[:id])
    user= ( has_manage_novel_permission and !params[:author_name].blank?) ? User.find_by_user_name([:author_name]) : current_user
    params[:chapter][:author_id]=user.id
    if @chapter.update_attributes(chapter_params)
      flash[:success] = t('my.notice.update_success')
      redirect_to @chapter.novel
    else
      render 'edit'
    end
  end

  def edit
    @chapter=Chapter.find(params[:id])
    has_manage_novel_permission
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
