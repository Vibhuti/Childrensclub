class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user = current_user
    if @user && @user.admin?
      @videos = Video.all
    else
      @videos = Video.public_videos
    end
    respond_with(@videos)
  end

  def show
    respond_with(@video)
  end

  def new
    @video = Video.new
    respond_with(@video)
  end

  def edit
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to videos_path, :notice => "Successfully Uploaded"
      else
      redirect_to videos_path, :notice => "Failed to upload. Please try again."
    end
  end

  def update
    @video.update(video_params)
    if @video.save
      redirect_to videos_path, :notice => "Successfully Uploaded"
      else
      redirect_to videos_path, :notice => "Failed to upload. Please try again."
    end
  end

  def destroy
    @video.destroy
    respond_with(@video)
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:public, :youtube_video)
    end
end
