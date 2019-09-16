class Api::V1::PostsController < ApplicationController
  def create
    form = PostForm.new(post_params)
    if form.valid?
      @post = PostCreationService.new(post_params).call
    else
      render_unprocessable_entity(form.errors.full_messages)
    end
  end

  def ip_list
    @posts = LoginIp.group(:ip).having('count(login) > 1').select("ip, array_agg(login) as logins")
  end

  def top
    @posts = Post.order(:rating)
                 .limit(params[:amount] || 10)
                 .select(:title, :body)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :ip, :login)
  end
end
