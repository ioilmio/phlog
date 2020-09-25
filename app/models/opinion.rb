class Opinion < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :user_id, presence: true
  validates :content, presence: true
  scope :most_recent, -> { order(created_at: :desc) }

  validates :image, attached: true, content_type: { in: ['image/jpeg', 'image/gif', 'image/png', 'image/jpg'],
                                                    message: 'must be a valid image format' },
                    size: { less_than: 5.megabytes,
                            message: 'should be less than 5MB' }
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
