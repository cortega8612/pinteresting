class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /pins
  def index
    @pins = Pin.all.order("created_at DESC") .limit(3)
  end

  # GET /pins/1
  def show
  end

  # GET /pins/new
  def new
    @pin = current_user.pins.build
  end

  # GET /pins/1/edit
  def edit
  end

  # POST /pins
  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
       render :new 
    end
  end

  # PATCH/PUT /pins/1
  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.' 
    else
      render :edit 
    end
  end

  # DELETE /pins/1
  
  def destroy
    @pin.destroy
    redirect_to pins_url, notice: 'Pin was successfully destroyed.' 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to modify this pin" if @pin.nil?
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
