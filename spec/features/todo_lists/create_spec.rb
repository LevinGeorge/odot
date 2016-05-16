require 'spec_helper'

describe "Creating todo lists" do
  it "redirects to todo list index page" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "My to do list"
    fill_in "Description", with: "Sample text"
    click_button "Create Todo list"

    expect(page).to have_content("My todo list")
  end

  it "displays an error when there is no title" do
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: ""
    fill_in "Description", with: "Sample text"
    click_button "Create Todo list"

    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit "/todo_lists"
    expect(page).to_not have_content("Sample text")
  end

  it "displays an error when there the title has less than 5 characters" do
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")

    fill_in "Title", with: "Bye"
    fill_in "Description", with: "Sample text"
    click_button "Create Todo list"

    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit "/todo_lists"
    expect(page).to_not have_content("Sample text")

  end



end
