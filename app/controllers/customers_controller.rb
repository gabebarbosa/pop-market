class CustomersController < ApplicationController
  before_action :authorize
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @name_search = params[:name]
    @customers = Customer.where(user_id: current_user.id).where("name ilike ?", "%#{@name_search}%")
  end

  def show
    @customer = Customer.find(params[:id])
    unless current_user.id == @customer.user_id
      redirect_to customers_path
    end
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find(params[:id])
 
    unless current_user.id == @customer.user_id
      redirect_to customers_path
    end
  end

  def create
    @customer = Customer.new(customer_params)

    @customer.user_id = current_user.id

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Cliente cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Cliente atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    unless current_user.id == @customer.user_id
      redirect_to products_path
    end

    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Cliente deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :contact, :user_id)
    end
end
