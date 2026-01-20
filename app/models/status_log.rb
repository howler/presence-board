class StatusLog < ApplicationRecord
  belongs_to :user
  belongs_to :status

  validates :user_id, presence: true
  validates :status_id, presence: true
end
