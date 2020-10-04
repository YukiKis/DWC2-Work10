class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50}

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefectire_name).code
  end

  # When you want to see all books not only posted by yourself but also by your followings
  # def feed
  #   followings_ids = "SELECT followed_id FROM relatioships where followed_id = :user_id"
  #   Books.where("user_id in #{followings_ids} OR user_id = :user_id", user_id: id)
  # end

  def follow(other_user)
    self.followings << other_user
  end

  def unfollow(other_user)
    self.active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def address
    "〒#{self.postcode.to_s.chars[0..2].join}-#{self.postcode.to_s.chars[3..6].split.join} #{self.prefecture_code.try(:name)} #{self.address_city} #{self.address_street} #{self.address_building}"
  end
end
