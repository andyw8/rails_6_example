module Sections
  class NewTodoItem < SitePrism::Section
    element :title, '#title'
    element :add, '#add'
  end
end
