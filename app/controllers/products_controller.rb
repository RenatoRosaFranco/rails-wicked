# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def new
    @product = Product.new
  end

  def show; end

  def create
    product = Product.new(product_params)

    if product.save
      redirect_to product_build_path(id: :add_price, product_id: product.id)
    else
      render :new
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name)
  end
end