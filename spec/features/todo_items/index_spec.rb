require 'spec_helper'

describe "Viewing todo_items" do
  let!(:todo_list) {TodoList.create(title: "Grocery list", description: "Buy groceries")}
  before do
    visit "/todo_lists "
    within "#{todo_list.id}" do
      click_link "List Items"
    end
  end

  it "displays the title of the todo list" do
    within("h1") do
      expect(page).to have_content(todo_list.title)
    end
  end

  it "displays no items when todo_items is empty" do

    expect(page).to have_content("TodoItems#Index")
  end
end
