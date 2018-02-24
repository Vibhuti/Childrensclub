class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @testimonials = Testimonial.all
    respond_with(@testimonials)
  end

  def show
    respond_with(@testimonial)
  end

  def new
    @testimonial = Testimonial.new
    respond_with(@testimonial)
  end

  def edit
  end

  def create
    @testimonial = Testimonial.new(testimonial_params)
    @testimonial.user_id = current_user.id

    respond_to do |format|
      if @testimonial.save!
        format.html {
          redirect_to testimonials_path,
          notice: 'Testimonial was successfully created.'
        }
        format.json { render action: 'show', status: :created, location: @testimonial }
      else
        format.html { render action: 'new' }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @testimonial.update(testimonial_params)
    respond_with(@testimonial)
  end

  def destroy
    @testimonial.destroy
    respond_with(@testimonial)
  end

  private
    def set_testimonial
      @testimonial = Testimonial.find(params[:id])
    end

    def testimonial_params
      params.require(:testimonial).permit(:entry, :user_id)
    end
end
