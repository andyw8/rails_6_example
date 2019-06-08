require "rails_helper"
require "pages/todo_list"

RSpec.describe "Manage todos", type: :system do
  it "lists todos" do
    create(:item, title: "Buy apples")
    create(:item, title: "Buy bananas")

    @page = Pages::TodoList.new.tap(&:load)
    visit root_path

    expect(@page.item_titles).to eq(["Buy apples", "Buy bananas"])
  end

  it "allows adding" do
    visit root_path

    @page = Pages::TodoList.new
    @page.load
    @page.new_todo_item.title.set("Buy apples")
    @page.new_todo_item.add.click

    fill_in "Title", with: "Buy apples"
    click_button "Add Item"

    expect(@page.item_titles).to eq(["Buy apples"])
  end

  it "allows deleting" do
    apples = create(:item, title: "Buy apples")
    _bananas = create(:item, title: "Buy bananas")
    visit root_path

    @page = Pages::TodoList.new
    @page.load

    expect(@page.item_titles).to eq(["Buy apples", "Buy bananas"])

    within("#todo-item-#{apples.id}") do
      click_button "Delete"
    end

    expect(@page.item_titles).to eq(["Buy bananas"])
  end
end
