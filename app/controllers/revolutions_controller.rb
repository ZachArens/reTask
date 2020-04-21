class RevolutionsController < ApplicationController
  before_action :set_statuses
  before_action :set_revolution, only: [:show, :edit, :update, :destroy]
  before_action :set_movement, only: [:show, :edit, :update, :destroy]

  # GET /revolutions
  # GET /revolutions.json
  def index
    @revolutions = Revolution.all
  end

  # GET /revolutions/1
  # GET /revolutions/1.json
  def show
  end

  # GET /revolutions/new
  def new
    @revolution = Revolution.new
  end

  # GET /revolutions/1/edit
  def edit
  end

  # POST /revolutions
  # POST /revolutions.json
  def create
    @revolution = Revolution.new(revolution_params)
    movement = Movement.find(revolution_params[:movement_id])
    @revolution.build_movement(id: movement.id)

    respond_to do |format|
      if @revolution.save
        format.html { redirect_to @revolution, notice: 'Revolution was successfully created.' }
        format.json { render :show, status: :created, location: @revolution }
      else
        format.html { render :new }
        format.json { render json: @revolution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revolutions/1
  # PATCH/PUT /revolutions/1.json
  def update
    respond_to do |format|
      if @revolution.update(revolution_params)
        format.html { redirect_to @revolution, notice: 'Revolution was successfully updated.' }
        format.json { render :show, status: :ok, location: @revolution }
      else
        format.html { render :edit }
        format.json { render json: @revolution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revolutions/1
  # DELETE /revolutions/1.json
  def destroy
    @revolution.destroy
    respond_to do |format|
      format.html { redirect_to revolutions_url, notice: 'Revolution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_statuses
    @statuses = Revolution.statuses
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_movement
    @movement = Movement.find(revolution_params[:movement_id])
  end

  def set_revolution
    @revolution = Revolution.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def revolution_params
    params.require(:revolution).permit(:repeater_vals, :total_seconds, :status, :movement_id)
  end
end
