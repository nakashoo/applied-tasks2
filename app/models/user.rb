class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image


  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  #中間テーブルを通し、followerモデルのフォローされる側を取得
  has_many :followed_sides, through: :followers, source: :followed

  #中間テーブルを通し、followedモデルのフォローする側を取得
  has_many :follower_sides, through: :followeds, source: :follower

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end


  def follow(user_id)
    followers.create(followed_id: user_id)
  end

  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end

  def following?(user)
   followed_sides.include?(user)
  end


end
