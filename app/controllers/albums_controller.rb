class AlbumsController < ApplicationController
	before_filter :authenticate_user!, only: [:create, :new, :update, :edit, :destroy]
	before_filter :find_user
  before_action :find_album, only: [:edit, :update, :destroy]
	before_filter :ensure_proper_user, only: [:create, :new, :update, :edit, :destroy]
	before_filter :add_breadcrumbs

  def index
    @albums = Album.all
  end

  def show
		redirect_to album_pictures_path(params[:id])
  end

  def new
    @album = current_user.albums.new
  end

  def edit
		add_breadcrumb "Editing Album"
  end

  def create
    @album = current_user.albums.new(album_params)

    respond_to do |format|
      if @album.save
				current_user.create_activity @album, 'created'
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
				current_user.create_activity @album, 'updated'
        format.html { redirect_to album_pictures_path(@album), notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album.destroy
    respond_to do |format|
			current_user.create_activity @album, 'deleted'
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
	
	def url_options 
		{ profile_name: params[:profile_name] }.merge(super)
	end

  private
		def ensure_proper_user
    	if current_user != @user
      	flash[:error] = "You don't have permission to do that."
      	redirect_to albums_path
    	end
  	end
	
		def add_breadcrumbs
			add_breadcrumb @user.first_name, profile_path(@user)
			add_breadcrumb "Albums", albums_path
  	end
	
		def find_user 
			@user = User.find_by_profile_name(params[:profile_name])
		end

    def find_album
      @album = current_user.albums.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:user_id, :title)
    end
end
