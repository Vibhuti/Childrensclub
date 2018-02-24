class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if current_user && current_user.confirmed?
      @photos = Photo.all
    else
      @photos = Photo.all.where(:public => true)
    end
    respond_with(@public_photos)
  end

  def show
    respond_with(@photo)
  end

  def new
    @photo = Photo.new
    respond_with(@photo)
  end

  def edit
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photos_path, :notice => "Successfully Uploaded"
    else
      redirect_to photos_path, :notice => "Failed to upload. Please try again."
    end
  end

  def update
    @photo.update(photo_params)
    respond_with(@photo)
  end

  def destroy
    @photo.destroy
    respond_with(@photo)
  end

  private
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:name, :image, :remote_image_url, :public)
    end
end
