require "sections/new_todo_item"
require "sections/item"
require "sections/item"
require "pages/support/wait_for_xhr"

module Pages
  class TodoList < SitePrism::Page
    include WaitForXhr
    set_url '/'
    sections :items, Sections::Item, "li.todo-item"
    section :new_todo_item, Sections::NewTodoItem, '#new-todo-item'

    def item_titles
      wait_for_xhr
      items.map(&:label_text)
    end

    def item(name)
      items.detect { |item| item.label_text == name } || raise("Item '#{name}' not found")
    end
  end
end
