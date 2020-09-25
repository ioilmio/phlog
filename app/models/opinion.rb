class Opinion < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true
  scope :most_recent, -> { order(created_at: :desc) }end
