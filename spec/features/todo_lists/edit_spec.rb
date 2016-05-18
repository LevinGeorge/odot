require 'spec_helper'

describe "Editing todo lists" do
  let!(:todo_list) {TodoList.create(title:"Groceries", description: "Grocery List")
}

  def update_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "My description for the todo_list"

    todo_list = options[:todo_list]

    visit "/todo_lists"
    within "#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end

  it "updates todo list successfully with correct parameters" do
    todo_list = TodoList.create(title:"Groceries", description: "Grocery List")
    update_todo_list todo_list: todo_list,
                     title: "New Title",
                     description: "New Description"

    todo_list.reload
    expect(page).to have_content("Todo lsit was updated")
    expect(todo_list.title).to eq("New Title")
    expect(todo_list.description).to eq("New Description")
  end

  it "displays an error with no title" do
    update_todo_list todo_list: todo_list,
                     description: "New Description",
                     title:""
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content("error")
  end

  it "displays an error when the title is too short" do
    update_todo_list todo_list: todo_list,
                     title: "Hi",
                     description: "New Description"
    expect(page).to have_content("error")
  end

  it "displays an error when there is no description" do
    update_todo_list todo_list: todo_list,
                     title: "Hi",
                     description: ""
    expect(page).to have_content("error")
  end

  it "displays an error when the description is too short" do
    update_todo_list todo_list: todo_list,
                     title: "Hi",
                     description: "Test"
    expect(page).to have_content("error")
  end
end
