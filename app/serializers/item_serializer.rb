class ItemSerializer < ActiveModel::Serializer
  # default_includes :category, :outfits
  attributes :id, :title, :color, :condition, :brand, :category
  has_many :outfits
 
end
