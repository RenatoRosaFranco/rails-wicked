# frozen_string_literal: true

module Products
  class BuildController < ApplicationController
    include Wicked::Wizard

    steps :add_verification, :add_price, :add_category

    before_action :set_product, only: [:show, :update]

    def create
      @product = Product.create
      redirect_to wizard_path(steps.first, product_id: @product.id)
    end

    def show
      case step
      when :add_verification
        redirect_to next_wizard_path if @product.verified?
      else
        render_wizard
      end
    end

    def update
      case step
      when :add_verification
        if @product.verification_code.eql?(product_params[:verification_code])
          @product.verify_product

          redirect_to next_wizard_path
        else
          render step
        end
      when :add_price
        @product.update_attributes(product_params)
        redirect_to next_wizard_path
      when :add_category
        @product.update_attributes(product_params)
        redirect_to finish_wizard_path
      end
    end

    private

    def finish_wizard_path
      product_path(@product)
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def product_params
      params.require(:product)
        .permit(:price, :verification_code, :category)
    end
  end
end
