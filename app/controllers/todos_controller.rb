class TodosController < ApplicationController
  def index
    render json: TodoSerializer.new(Todo.by_position).serialized_json
  end

  def show
    todo = Todo.find(params[:id])

    render json: TodoSerializer.new(todo).serialized_json
  end

  def create
    todo = Todo.new(todo_params)

    if todo.save
      serialized_todo = TodoSerializer.new(todo).serialized_json
      render json: serialized_todo, status: :created, location: todo
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  def update
    todo = Todo.find(params[:id])
    if todo.update(todo_params)
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy!
    head :no_content
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :completed, :order)
  end
end
