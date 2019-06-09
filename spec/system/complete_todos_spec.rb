require "rails_helper"
require "pages/todo_list"

RSpec.describe "Complete todos", type: :system do
  it "completes todos" do
    list = create(:list)
    buy_apples = create(:item, title: "Buy apples", list: list)
    buy_bananas = create(:item, title: "Buy bananas", list: list)
    @todo_list = Pages::TodoList.new
    @todo_list.load(list_id: list.id)

    @todo_list.item("Buy bananas").complete

    # TODO: should this check the page contents rather than DB?
    expect(buy_bananas.reload).to be_completed
    expect(buy_apples.reload).to_not be_completed
  end
end
