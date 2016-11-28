class Client < ApplicationRecord
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  has_many :services, dependent: :destroy
  has_many :tasks, dependent: :destroy

  scope :confirmed, -> { where.not(confirmed_at: nil) }

  validates :name, :email, :site, presence: true
  validates :name, length: {minimum: 3, maximum: 32}
  validates_uniqueness_of :email
  validates_format_of :email, with: EMAIL_REGEXP
end
