class ChapterCommentsController < ApplicationController
  def create
    chapter_id=params[:chapter_id]
    content=params[:chapter_comment][:content]

    nc=ChapterComment.new
    nc.update_attributes(chapter_id: chapter_id,
                         user_id: current_user.id,
                         content: content)
    if nc.save
      flash[:notice]='添加成功'
      redirect_to request.referrer
    end
  end

  def destroy
  end

  def update
  end
end
