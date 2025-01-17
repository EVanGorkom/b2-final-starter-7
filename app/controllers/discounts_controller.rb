class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    if params[:threshold].present? && params[:percentage].present?
      new_discount = Discount.create!(threshold: params[:threshold], percentage: params[:percentage], merchant: @merchant)
      redirect_to merchant_discounts_path(@merchant)
      flash[:alert] = "Discount Created!"
    else
      flash[:error] = "The Discount was not created. Please enter a number value for both the Percentage Off and Quantity to Qualify attributes."
      redirect_to new_merchant_discount_path(@merchant)
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.find(params[:id])
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.find(params[:id])
    if discount.update(discount_params)
      redirect_to merchant_discount_path(@merchant, discount)
    else
      redirect_to edit_merchant_discount_path(@merchant, discount)
    end
  end

  private

  def discount_params
    params.permit(:percentage, :threshold)
  end
end