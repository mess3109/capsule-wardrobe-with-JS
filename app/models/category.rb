class Category < ApplicationRecord
	has_many :items

	validates :title, :presence => true, :uniqueness => true
end
