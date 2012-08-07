class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

  def create
  	@micropost = current_user.microposts.build(params[:micropost])
  	if @micropost.save
  		flash[:success] = 'Successfully created a new post'
  		redirect_to root_path
  	else
  		render 'static_pages/home'
  	end
  end

  def index
  end

  def destroy
  end
end