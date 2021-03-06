class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:github]

  has_many :items
  has_many :item_outfits
  has_many :outfits
  has_many :categories, -> { distinct }, :through => :items
  has_many :seasons, -> { distinct }, :through => :outfits

  validates :email, :presence => true
  validates :password, :presence => true

  belongs_to :current_outfit, :class_name => "Outfit", :optional => true

  def self.from_omniauth(auth)  
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def items_sorted_by_category
    self.items.sort_by { |item| item.category.title }
  end

  def outfits_sorted_by_season
    self.outfits.sort_by { |outfit| outfit.season.title }
  end
end
