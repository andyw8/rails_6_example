require "rails_helper"
require "pages/todo_list"

RSpec.describe "Complete todos", type: :system do
  it "completes todos" do
    buy_apples = create(:todo, title: "Buy apples")
    buy_bananas = create(:todo, title: "Buy bananas")
    @todo_list = Pages::TodoList.new
    @todo_list.load

    @todo_list.item("Buy bananas").complete

    expect(buy_bananas.reload).to be_completed
    expect(buy_apples.reload).to_not be_completed
  end
end
