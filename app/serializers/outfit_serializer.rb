class OutfitSerializer < ActiveModel::Serializer
  attributes :id, :title, :outfit_type, :season_id
  has_many :items
end
