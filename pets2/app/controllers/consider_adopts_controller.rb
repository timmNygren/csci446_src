class ConsiderAdoptsController < ApplicationController
  include CurrentConsider
  before_action :set_consider, only: [:create]
  before_action :set_consider_adopt, only: [:show, :edit, :update, :destroy]

  # GET /consider_adopts
  # GET /consider_adopts.json
  def index
    @consider_adopts = ConsiderAdopt.all
  end

  # GET /consider_adopts/1
  # GET /consider_adopts/1.json
  def show
  end

  # GET /consider_adopts/new
  def new
    @consider_adopt = ConsiderAdopt.new
  end

  # GET /consider_adopts/1/edit
  def edit
  end

  # POST /consider_adopts
  # POST /consider_adopts.json
  def create
    pet = Pet.find(params[:pet_id])
    @consider_adopt = @consider.add_pet(pet.id)

    respond_to do |format|
      if @consider_adopt.save
        format.html { redirect_to fosterhome_url }
        format.js   { @current_consider = @consider_adopt }
        format.json { render action: 'show', status: :created, location: @consider_adopt }
      else
        format.html { render action: 'new' }
        format.json { render json: @consider_adopt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consider_adopts/1
  # PATCH/PUT /consider_adopts/1.json
  def update
    respond_to do |format|
      if @consider_adopt.update(consider_adopt_params)
        format.html { redirect_to @consider_adopt, notice: 'Consider adopt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @consider_adopt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consider_adopts/1
  # DELETE /consider_adopts/1.json
  def destroy
    @consider_adopt.destroy
    respond_to do |format|
      format.html { redirect_to consider_adopts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consider_adopt
      @consider_adopt = ConsiderAdopt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consider_adopt_params
      params.require(:consider_adopt).permit(:pet_id)
    end
end
