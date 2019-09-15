class PostCreationService
  def initialize(params)
    @login = params[:login]
    @post_params = params.except(:login)
  end

  def call
    user = User.find_or_create_by(login: @login)
    @post_params[:user_id] = user.id
    Post.create(@post_params)
  end
end
