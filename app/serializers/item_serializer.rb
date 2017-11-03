class ItemSerializer < ActiveModel::Serializer
  # default_includes :category, :outfits
  attributes :id, :title, :color, :condition, :brand, :category, :image
  has_many :outfits
 
end
