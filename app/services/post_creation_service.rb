class PostCreationService < ApplicationService
  def initialize(params)
    @login = params[:login]
    @ip = params[:ip]
    @title = params[:title]
    @body = params[:body]
  end

  def call
    user = User.find_or_create_by(login: @login)
    LoginIp.find_or_create_by(login: @login, ip: @ip)
    Post.create(title: @title, body: @body, ip: @ip, user_id: user.id)
  end
end