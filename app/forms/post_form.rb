class PostForm
  include ActiveModel::Validations

  attr_reader :params

  def initialize(params)
    @params = params
  end

  validates :title,
            presence: true,
            length: { maximum: 100 }

  validates :body,
            presence: true

  validates :login,
            presence: true

  validates :ip,
            presence: true

  def body
    params[:body]
  end

  def title
    params[:title]
  end

  def login
    params[:login]
  end

  def ip
    params[:ip]
  end
end