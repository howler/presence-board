class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  belongs_to :department, optional: true
  belongs_to :current_status, class_name: "Status", optional: true
  has_many :status_logs, dependent: :destroy

  validates :name, presence: true
  validates :role, inclusion: { in: %w[user admin] }, allow_nil: true

  before_validation :set_default_role, on: :create

  def admin?
    role == "admin"
  end

  def update_status!(status, note: nil)
    transaction do
      update!(current_status: status, current_note: note)
      status_logs.create!(status: status, note: note)
    end
  end

  private

  def set_default_role
    self.role ||= "user"
  end
end
