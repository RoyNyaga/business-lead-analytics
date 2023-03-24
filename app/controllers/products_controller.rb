class ProductsController < ApplicationController
  def create
    @product = Product.new(product_params)
    @business = Business.find_by(id: params[:product][:business_id])

    respond_to do |format|
      if @product.save
        format.html { redirect_to business_path(@business), notice: "Product was successfully Added" }
      else
        format.html { redirect_to business_path(@business), status: :unprocessable_entity }
      end
    end
  end

  private 

  def product_params
    params.require(:product).permit(:user_id, :business_id, :name)
  end
end
