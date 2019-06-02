require "rails_helper"

RSpec.describe "Todo management", type: :request do
  it "indexes" do
    create(:todo)

    get "/todos", headers: headers

    expect(response).to have_http_status(:ok)
    expect(parsed_response_data.first).to include(
      type: "todo"
    )
  end

  it "shows" do
    todo = create(:todo, title: "my title")

    get "/todos/#{todo.id}", headers: headers

    expect(parsed_response_data).to eq(
      attributes: {
        completed: false,
        order: 1,
        title: "my title"
      },
      id: todo.id.to_s,
      type: "todo"
    )
  end

  it "creates" do
    post "/todos", params: valid_params, headers: headers

    expect(response).to have_http_status(:created)
  end

  it "updates" do
    todo = create(:todo, title: "old")
    params = valid_params

    params[:todo][:title] = "new"
    patch "/todos/#{todo.id}", params: params, headers: headers

    expect(response).to have_http_status(:ok)
    expect(todo.reload.title).to eq("new")
  end

  it "destroys" do
    todo = create(:todo, title: "old")

    expect do
      delete "/todos/#{todo.id}", headers: headers
    end.to change { Todo.count }.by(-1)
    expect(response).to have_http_status(:no_content)
  end

  def valid_params
    { todo: attributes_for(:todo) }
  end

  def headers
    {
      "ACCEPT" => "application/json"
    }
  end

  def parsed_response_data
    parsed_response.fetch(:data)
  end

  def parsed_response
    expect(response.content_type).to eq("application/json")
    JSON.parse(response.body).deep_symbolize_keys
  end
end
