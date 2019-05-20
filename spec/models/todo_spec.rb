require "rails_helper"

RSpec.describe Todo, type: :model do
  it "prevents creation without a title" do
    expect do
      create(:todo, title: "")
    end.to raise_error ActiveModel::StrictValidationFailed, "Title can't be blank"
  end
end
