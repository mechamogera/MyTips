class UserController < ApplicationController
  def index
    @users = Users.all
  end
end
