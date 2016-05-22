require 'spec_helper'

describe "Viewing todo_items" do
  let!(:todo_list) {TodoList.create(title: "Grocery list", description: "Buy groceries")}

  it "displays no items when todo_items is empty" do
    visit "/todo_lists "
    within "#{todo_list.id}" do
      click_link "List Items"
    end
    expect(page).to have_content("TodoItems#Index")
  end
end
