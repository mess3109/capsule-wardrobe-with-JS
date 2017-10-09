class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :category_id, :color, :condition, :brand
  has_many :outfits
end
