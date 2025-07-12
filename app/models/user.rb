class User < ApplicationRecord
  has_secure_password

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts,
          through: :favorites,
          source: :post
  
  # バリデーション
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name,
            presence: true,
            length: { maximum: 50 }
  validates :password,
            length: { minimum: 4 },
            if: -> { new_record? || !password.nil? }

  # コールバック
  before_save :downcase_email

  def favorite(post)
    favorite_posts << post
  end

  def unfavorite(post)
    favorite_posts.destroy(post)
  end

  def favorited?(post)
    favorite_posts.include?(post)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
