class AdoptController < ApplicationController
  def index
  	@pet = Pet.find(params[:pet])
  end
end
