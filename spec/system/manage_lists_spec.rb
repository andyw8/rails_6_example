require "rails_helper"
require "pages/lists"

RSpec.describe "Manage lists", type: :system do
  it "lists lists" do
    create(:list, title: "List 1")
    create(:list, title: "List 2")

    @page = Pages::Lists.new
    @page.load

    expect(@page.list_titles).to eq(["List 1", "List 2"])
  end

  it "allows adding" do
    visit root_path

    click_link "New List"
    fill_in "Title", with: "My List"
    click_button "Create List"

    @page = Pages::Lists.new
    @page.load # needed?

    expect(@page.list_titles).to eq(["My List"])
  end
end
