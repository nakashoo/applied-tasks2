class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image

  has_many :subjective_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followerside, through: :subjective_relationships, source: :follower

  has_many :objective_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followedside, through: :objective_elationships, source: :followed



  has_many :relation, through: :relationships, source: :relationships


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end




end
