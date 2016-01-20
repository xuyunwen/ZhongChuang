class ChapterVotesController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]

  def create
    rate=params[:rate]
    chapter_id=params[:chapter_id]
    if current_user.vote_chapter(chapter_id, !!rate)
      flash[:notice]='成功'
    else
      flash[:notice]=' 不能重复投票'

    end
    redirect_to request.referrer
  end

  def destroy
  end

  def update
  end
end
