require "rails_helper"

RSpec.describe "Todo management", type: :request do
  it "lists Todos" do
    create(:todo)

    get "/todos", headers: headers

    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:ok)
    parsed_data = JSON.parse(response.body).fetch("data")
    expect(parsed_data.first).to include(
      { "type" => "todo" }
    )
  end

  it "creates a Todo" do
    post "/todos", params: valid_params, headers: headers

    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:created)
  end

  def valid_params
    { todo: attributes_for(:todo) }
  end

  def headers
    {
      "ACCEPT" => "application/json"
    }
  end
end
