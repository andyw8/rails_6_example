class TodosController < ApplicationController
  def index
    render json: TodoSerializer.new(Todo.all).serialized_json
  end

  def show
    todo = Todo.find(params[:id])

    render json: TodoSerializer.new(todo).serialized_json
  end

  def create
    todo = Todo.new(todo_params)

    if todo.save
      render :show, status: :created, location: todo
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  def todo_params
    params.require(:todo).permit(:title, :completed, :order)
  end
end
