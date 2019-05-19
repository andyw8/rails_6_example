class TodoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :order, :completed
end
