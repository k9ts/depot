class StoreController < ApplicationController
  
  def index
    if session[:counter].nil?
      counter = 1
      session[:counter] = counter
    else
      session[:counter] += 1
    end
    
    @products = Product.all
  end

end
