class OutfitSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :items
  belongs_to :season
end
