class FosterhomeController < ApplicationController
  def index
  	@pets = Pet.all
  end
end
