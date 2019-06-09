class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    list = List.find(params[:id])
    render locals: { list: list }
  end

  def new
    list = List.new
    render locals: { list: list }
  end

  def create
    list = List.new(list_params)
    list.save!
    redirect_to list
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end
end
