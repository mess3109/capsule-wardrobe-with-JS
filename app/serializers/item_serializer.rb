class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :color, :condition, :brand
  has_many :outfits
  belongs_to :category
end
