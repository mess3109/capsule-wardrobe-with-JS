class OutfitSerializer < ActiveModel::Serializer
  attributes :id, :title, :outfit_type
  has_many :items
  belongs_to :season
end
