class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_one_attached :profile_image


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  #   validate :custom_name_validation

  # private

  # def custom_name_validation
  #   if name.blank?
  #     errors.add(:name, "can't be blank")
  #   elsif name.length < 2
  #     errors.add(:name, "is too short (minimum is 2 characters)")
  #   end
  # end

end
