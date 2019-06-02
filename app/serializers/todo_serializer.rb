class TodoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :position, :completed
end
