class NovelsController < ApplicationController
  def index
  end

  def new
  end

  def show
    @novel=Novel.find(params[:id])
  end

  def create
  end

  def destroy
  end

  def update
  end

  def edit
  end
end
