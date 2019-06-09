require "rails_helper"

RSpec.describe "Item management", type: :request do
  let!(:list) { create(:list) }

  it "indexes" do
    create(:item, list: list)

    get "/api/v1/lists/#{list.id}/items", headers: headers

    expect(response).to have_http_status(:ok)
    expect(parsed_response_data.first).to include(
      type: "item"
    )
  end

  it "shows" do
    item = create(:item, title: "my title", list: list)

    get "/api/v1/lists/#{list.id}/items/#{item.id}", headers: headers

    expect(parsed_response_data).to eq(
      attributes: {
        completed: false,
        position: 1,
        title: "my title"
      },
      id: item.id.to_s,
      type: "item"
    )
  end

  it "creates" do
    post "/api/v1/lists/#{list.id}/items", params: valid_params, headers: headers

    expect(response).to have_http_status(:created)
  end

  it "updates" do
    item = create(:item, title: "old", list: list)
    params = valid_params

    params[:item][:title] = "new"
    patch "/api/v1/lists/#{list.id}/items/#{item.id}", params: params, headers: headers

    expect(response).to have_http_status(:ok)
    expect(item.reload.title).to eq("new")
  end

  it "destroys" do
    item = create(:item, title: "old", list: list)

    expect do
      delete "/api/v1/lists/#{list.id}/items/#{item.id}", headers: headers
    end.to change { Item.count }.by(-1)
    expect(response).to have_http_status(:no_content)
  end

  def valid_params
    { item: attributes_for(:item) }
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
