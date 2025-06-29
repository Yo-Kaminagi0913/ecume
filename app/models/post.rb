class Post < ApplicationRecord
  belongs_to :user
  has_many   :favorites, dependent: :destroy

  # スコープ
  scope :recent, -> { where(expired: false).where("created_at >= ?", 24.hours.ago) }

  # バリデーション
  validates :content,
            presence: true,
            length: { maximum: 500 }

  # コールバック
  after_create :schedule_expiration

  private

  def schedule_expiration
    ExpirePostJob.set(wait: 24.hours).perform_later(id)
  end
end
