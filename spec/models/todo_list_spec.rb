require 'rails_helper'

RSpec.describe TodoList, type: :model do
  it {should has_many(:todo_items)}end
end
