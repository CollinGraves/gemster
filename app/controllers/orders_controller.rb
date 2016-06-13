class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    render json: @orders
  end

  # POST /orders
  # POST /orders.json
  def create
    @table = Table.find(params[:table_id])
    @order = @table.orders.build(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def add
    @order = Order.find(params[:id])

    order_item = OrderItem.where(item_id: params[:item_id]).first.increment(:quantity) rescue
      @order.order_items.build(item_id: params[:item_id])

    if order_item.save
      render json: order_item, status: 201
    else
      render json: order_item.errors, status: :unprocessable_entity
    end
  end

  def pay
    @order = Order.find(params[:id])
    if @order.total_amount == params[:amount]
      @receipt = Receipt.new(order: @order, payment_method: params[:payment_method])
      if @receipt.save
        render json: @receipt, status: 204
      else
        render json: @receipt.errors, status: 422
      end
    end
  end

  private

    def order_params
      params.require(:order).permit(:name, :email, :table_id)
    end
end
