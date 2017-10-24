class OutfitSerializer < ActiveModel::Serializer
  # default_includes :items
  attributes :id, :title
  has_many :items
  belongs_to :season
end
