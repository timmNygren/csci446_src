class AdoptsController < ApplicationController
  before_action :set_adopt, only: [:show, :edit, :update, :destroy]

  # GET /adopts
  # GET /adopts.json
  def index
    @adopts = Pet.find(params[:pet_id])
  end

  # GET /adopts/1
  # GET /adopts/1.json
  def show
  end

  # GET /adopts/new
  def new
    @adopt = Adopt.new
  end

  # GET /adopts/1/edit
  def edit
  end

  # POST /adopts
  # POST /adopts.json
  def create
    @adopt = Pet.find(params[:pet_id])

    adopted = params[:adopted] || false

    respond_to do |format|
      if @adopt.save
        if adopted
          format.html { redirect_to fosterhome_url }
        else
          format.html { redirect_to adopts_url(pet_id: @adopt) }
        end
        format.json { render action: 'show', status: :created, location: @adopt }
      else
        format.html { render action: 'new' }
        format.json { render json: @adopt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adopts/1
  # PATCH/PUT /adopts/1.json
  def update
    respond_to do |format|
      if @adopt.update(adopt_params)
        format.html { redirect_to @adopt, notice: 'Adopt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @adopt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adopts/1
  # DELETE /adopts/1.json
  def destroy
    @adopt.destroy
    respond_to do |format|
      format.html { redirect_to adopts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adopt
      @adopt = Adopt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adopt_params
      params.require(:adopt).permit(:pet_id)
    end
end
