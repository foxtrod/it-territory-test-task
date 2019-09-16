class ReviewCreationService < ApplicationService
  def initialize(params, post)
    @mark = params[:mark]
    @post = post
  end

  def call
    @post.with_lock do
      amount = @post.marks_amount
      average = amount == 0 ? @mark : (@post.rating * amount + @mark) / (amount + 1)
      Review.create!(mark: @mark, post_id: @post.id)
      @post.update!(rating: average, marks_amount: amount + 1)
      @post.rating
    end
  end
end
