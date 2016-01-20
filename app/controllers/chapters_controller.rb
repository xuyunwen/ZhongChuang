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
    debugger
    user= ( has_manage_novel_permission and params[:novel][:author_id]) ? User.find([:novel][:author_id]) : current_user
    params[:chapter][:number]=@novel.new_chapter_num(user)
    if has_manage_novel_permission
      success= @chapter.update_attributes(manage_novel_user_params)
    else
      success= @chapter.update_attributes(common_user_params)
    end
    if success
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

  def common_user_params
    manage_novel_user_params.permit(:novel_id, :number,
                                    :cite_id, :title, :content,
                                    :summary, :subsequent_summary, :foreshadowing)
  end

  def manage_novel_user_params
    params.require(:chapter).permit(:novel_id, :number, :author_id,
                                    :status, :cite_id, :title, :content,
                                    :summary, :subsequent_summary, :foreshadowing)
  end

end
