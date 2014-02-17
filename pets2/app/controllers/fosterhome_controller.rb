class FosterhomeController < ApplicationController
  def index
  	@pets = Pet.order(:name)
  end
end
