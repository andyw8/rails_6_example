require "sections/new_todo_item"
require "sections/item"

module Pages
  class TodoList < SitePrism::Page
    set_url '/'
    sections :items, Sections::Item, "li.todo-item"
    section :new_todo_item, Sections::NewTodoItem, '#new-todo-item'

    def item_titles
      items.map(&:label_text)
    end

    def item(name)
      items.detect { |item| item.label_text == name } || raise("Item '#{name}' not found")
    end
  end
end
