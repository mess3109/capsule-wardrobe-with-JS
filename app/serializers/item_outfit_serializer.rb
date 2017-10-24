class ItemOutfitSerializer < ActiveModel::Serializer
	# default_includes :item, :outfit
  attributes :id
  belongs_to :item
  belongs_to :outfit
end
