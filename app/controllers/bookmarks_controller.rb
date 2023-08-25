class BookmarksController < ApplicationController
  before_action :set_list, only: :create
  before_action :set_bookmark, only: :destroy

  # 'new' is not used since we show the form in the lists#show action

  # def new
  #   @bookmark = Bookmark.new
  # end

  def create
    @bookmark = Bookmark.new(bookmarks_params)
    @bookmark.list = @list

    if @bookmark.save
      redirect_to list_path(@list)
    else
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmarks_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
