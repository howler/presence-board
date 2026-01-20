class Status < ApplicationRecord
  has_many :status_logs, dependent: :destroy
  has_many :users, foreign_key: :current_status_id, dependent: :nullify
  validates :label, presence: true, uniqueness: true
  validates :color_code, presence: true
end
