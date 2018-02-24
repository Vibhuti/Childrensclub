class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :redirect_if_not_admin

  respond_to :html

  def index
    @messages = Message.all
    respond_with(@messages)
  end

  def show
    respond_with(@message)
  end

  def new
    @user = current_user
    @message = Message.new
  end

  def edit
  end

  def create
    @user = current_user
    @message = @user.messages.build(message_params)
    puts message_params
    respond_to do |format|
      if @message.save
        if @message.parent_id.nil?
          admin_broadcast_message
        else
          admin_single_parent_message
        end
        format.html { redirect_to static_pages_home_path, notice: "message successfully created" }
      else
        format.html { render action: "new" }
      end
    end
  end

  def admin_single_parent_message
    UserMailer.send_digest(User.find(@message.parent_id), @message).deliver
  end

  def admin_broadcast_message
    User.all.each do |u|
      UserMailer.send_digest(u, @message).deliver
    end
  end

  def update
    @message.update(message_params)
    respond_with(@message)
  end

  def destroy
    @message.destroy
    respond_with(@message)
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

  def redirect_if_not_admin
    unless current_user.admin?
      redirect_to new_user_registration_path, notice: 'Only admin can view all children'
    end
  end

    def message_params
      params.require(:message).permit(:name, :title, :content, :user_id, :parent_id)
    end
end
