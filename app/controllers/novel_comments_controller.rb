class NovelCommentsController < ApplicationController
  def create
    novel_id=params[:novel_id]
    content=params[:novel_comment][:content]

    nc=NovelComment.new
    nc.update_attributes(novel_id: novel_id,
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
