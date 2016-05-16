require 'spec_helper'

describe "Creating todo lists" do

  def create_todo_lists(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "My description for the todo_list"

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

  it "redirects to todo list index page" do
    create_todo_lists
    expect(page).to have_content("My todo list")
  end

  it "displays an error when there is no title" do
    expect(TodoList.count).to eq(0)

    create_todo_lists title: ""

    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit "/todo_lists"
    expect(page).to_not have_content("Sample text")
  end

  it "displays an error when the title has less than 5 characters" do
    expect(TodoList.count).to eq(0)
    create_todo_lists title: "Hi"
    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit "/todo_lists"
    expect(page).to_not have_content("Sample text")
  end

  it "displays an error when there is no description" do
    expect(TodoList.count).to eq(0)
    create_todo_lists description: ""
    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit "/todo_lists"
    expect(page).to_not have_content("Groceries")
  end

  it "displays an error when the description has less than 10 characters" do
    expect(TodoList.count).to eq(0)
    create_todo_lists description: "sample"
    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit "/todo_lists"
    expect(page).to_not have_content("Bye")
  end
end
