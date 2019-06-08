class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :position, :completed
end
