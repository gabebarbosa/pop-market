class ProductsController < ApplicationController
  before_action :authorize
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  # GET /products
  # GET /products.json
  def index
    @name_search = params[:name]
    @products = Product.where(user_id: current_user.id).where("name ilike ?", "%#{@name_search}%")
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    unless current_user.id == @product.user_id
      redirect_to products_path
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])

    @product.price = @product.price == nil ? 0 : @product.price 
    unless current_user.id == @product.user_id
      redirect_to products_path
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    @product.user_id = current_user.id
    @product.amount = 0

    @product.price = @product.price == nil ? 0 : @product.price

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    unless current_user.id == @product.user_id
      redirect_to products_path
    end
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :amount, :user_id, :price)
    end
end
