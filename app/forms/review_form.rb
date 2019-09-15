class ReviewForm
  include ActiveModel::Validations

  attr_reader :params

  def initialize(params)
    @params = params
  end

  validates :mark,
            presence: true,
            inclusion: 1..5

  def mark
    params[:mark]&.to_i
  end
end