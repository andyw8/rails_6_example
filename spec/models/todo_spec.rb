require "rails_helper"

RSpec.describe Todo, type: :model do
  it "prevents creation without a title" do
    expect do
      create(:todo, title: "")
    end.to raise_error ActiveModel::StrictValidationFailed, "Title can't be blank"
  end

  it "assigns a position" do
    todo = create(:todo)
    another_todo = create(:todo)

    expect(todo.position).to eq(1)
    expect(another_todo.position).to eq(2)
  end

  describe "by_position" do
    it "orders by position" do
      build(:todo, title: "a").insert_at(1)
      build(:todo, title: "c").insert_at(3)
      build(:todo, title: "b").insert_at(2)

      result = Todo.by_position

      expect(result.pluck(:title)).to eq(%w[a b c])
    end
  end
end
