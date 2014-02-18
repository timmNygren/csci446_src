class AdoptController < ApplicationController
  def index
  	begin
	  	@pet = Pet.find(params[:pet])
	  rescue ActiveRecord::RecordNotFound
	  	logger.error "Attempt to access invalid pet #{params[:pet]}"
	  	redirect_to fosterhome_url, :notice => 'Invalid pet'
	  	return
	  end
  end

  def user_params
  	params.require(:pet)
  end
end
