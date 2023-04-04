class ProductsController < ApplicationController
  before_action :set_product, only: [:update, :destroy]

  def create
    @product = Product.new(product_params)
    @business = Business.find_by(id: params[:product][:business_id])

    respond_to do |format|
      if @product.save
        format.html { redirect_to business_path(@business), notice: "Product was successfully Added." }
      else
        format.html { redirect_to business_path(@business), status: :unprocessable_entity, alert: "Error: Product could not be created.", status: :unprocessable_entity }
      end
    end
  end

  def update
    @business = @product.business

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to business_path(@business), notice: "Product was successfully updated" }
      else
        format.html { redirect_to business_path(@business), status: :unprocessable_entity, alart: "Error!!, Product could not be updated: #{@product.errors.full_message.join(",")}" }
      end
    end
  end

  def destroy
    @product.destroy
    @business = @product.business

    flash[:notice] = "Product was successfully destroyed"
    redirect_to business_path(@business)
  end

  def set_product
    @product = Product.find_by(id: params[:id])
  end

  private 

  def set_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.require(:product).permit(:user_id, :business_id, :name)
  end
end
