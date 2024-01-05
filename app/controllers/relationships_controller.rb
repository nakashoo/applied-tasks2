class RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followedsides
    user = User.find(params[:user_id])
    @users = user.followedsides
  end

  def followersides
    user = User.find(params[:user_id])
    @users = user.followersides
  end

end
