require "rails_helper"

RSpec.describe Item, type: :model do
  it "prevents creation without a title" do
    expect do
      create(:item, title: "")
    end.to raise_error ActiveModel::StrictValidationFailed, "Title can't be blank"
  end

  it "assigns a position" do
    item = create(:item)
    another_item = create(:item)

    expect(item.position).to eq(1)
    expect(another_item.position).to eq(2)
  end

  describe "by_position" do
    it "orders by position" do
      build(:item, title: "a").insert_at(1)
      build(:item, title: "c").insert_at(3)
      build(:item, title: "b").insert_at(2)

      result = Item.by_position

      expect(result.pluck(:title)).to eq(%w[a b c])
    end
  end
end
