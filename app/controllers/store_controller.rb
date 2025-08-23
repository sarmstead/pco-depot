class StoreController < ApplicationController
  layout "store"

  def index
    @products = Product.order(:title)
  end
end
