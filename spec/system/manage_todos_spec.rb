require "rails_helper"
require "pages/todo_list"

RSpec.describe "Manage todos", type: :system do
  let!(:list) { create(:list) }

  it "lists todos" do
    create(:item, title: "Buy apples", list: list)
    create(:item, title: "Buy bananas", list: list)

    @page = Pages::TodoList.new
    @page.load(list_id: list.id)

    expect(@page.item_titles).to eq(["Buy apples", "Buy bananas"])
  end

  it "allows adding" do
    visit root_path

    @page = Pages::TodoList.new
    @page.load(list_id: list.id)
    @page.new_todo_item.title.set("Buy apples")
    @page.new_todo_item.add.click

    expect(@page.item_titles).to eq(["Buy apples"])
  end

  it "allows deleting" do
    apples = create(:item, title: "Buy apples", list: list)
    _bananas = create(:item, title: "Buy bananas", list: list)
    visit root_path

    @page = Pages::TodoList.new
    @page.load(list_id: list.id)

    expect(@page.item_titles).to eq(["Buy apples", "Buy bananas"])

    within("#todo-item-#{apples.id}") do
      click_button "Delete"
    end

    expect(@page.item_titles).to eq(["Buy bananas"])
  end
end
