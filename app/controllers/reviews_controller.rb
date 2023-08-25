class ReviewsController < ApplicationController
  before_action :set_list, only: %i[create]

  def create
    @review = Review.new(review_params)
    @review.list = @list

    if @review.save
      redirect_to list_path(@list), notice: 'Review added'
    else
      render 'lists/new', status: :unprocessable_entity
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
