module API::V1
  class ItemsController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      render json: ItemSerializer.new(Item.by_position).serialized_json
    end

    def show
      item = Item.find(params[:id])

      render json: ItemSerializer.new(item).serialized_json
    end

    def create
      item = Item.new(item_params)
      item.list = List.last!

      if item.save
        serialized_item = ItemSerializer.new(item).serialized_json
        render json: serialized_item, status: :created, location: api_v1_item_path(item)
      else
        render json: item.errors, status: :unprocessable_entity
      end
    end

    def update
      item = Item.find(params[:id])
      if item.update(item_params)
        render json: { status: :ok }
      else
        render json: { status: :unprocessable_entity }
      end
    end

    def destroy
      item = Item.find(params[:id])
      item.destroy!
      head :no_content
    end

    private

    def item_params
      params.require(:item).permit(:title, :completed, :order)
    end
  end
end
