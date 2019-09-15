class Api::V1::ReviewsController < ApplicationController
  def create
    post = Post.find(params[:id])
    form = ReviewForm.new(review_params)

    if form.valid?
      @rating = ReviewCreationService.call(review_params, post)
    else
      render_unprocessable_entity(form.errors.full_messages)
    end
  end

  private

  def review_params
    params.require(:review).permit(:mark)
  end
end
