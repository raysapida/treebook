class ProfilesController < ApplicationController
  def show
    @user = User.find_by(profile_name: params[:id])
    if @user
      @statuses = @user.statuses.all
      render action: :show
    else
      render file: Rails.root.join('public', '404.html'), status: 404, formats: [:html], layout: false
    end
  end
end
