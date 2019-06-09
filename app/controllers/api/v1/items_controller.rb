module API::V1
  class ItemsController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      render json: ItemSerializer.new(scoped_items.by_position).serialized_json
    end

    def show
      item = scoped_items.find(params[:id])

      render json: ItemSerializer.new(item).serialized_json
    end

    def create
      item = scoped_items.new(item_params)

      if item.save
        serialized_item = ItemSerializer.new(item).serialized_json
        render json: serialized_item, status: :created, location: api_v1_list_item_path(item.list, item)
      else
        render json: item.errors, status: :unprocessable_entity
      end
    end

    def update
      item = scoped_items.find(params[:id])
      if item.update(item_params)
        render json: { status: :ok }
      else
        render json: { status: :unprocessable_entity }
      end
    end

    def destroy
      item = scoped_items.find(params[:id])
      item.destroy!
      head :no_content
    end

    private

    def scoped_items
      @scoped ||= List.find(params[:list_id]).items
    end

    def item_params
      params.require(:item).permit(:title, :completed, :order)
    end
  end
end
