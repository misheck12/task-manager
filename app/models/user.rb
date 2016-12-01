class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  mount_uploader :photo, PhotoUploader
  mount_uploader :background, PhotoUploader

  has_many :tasks, dependent: :destroy

  scope :confirmed, -> { where.not(confirmed_at: nil) }

  enum roles: [ :admin, :manager, :employee, :only_task ]

  validates :email, :full_name, presence: true
  validates :full_name, length: {minimum: 3, maximum: 32}
  validates_uniqueness_of :email
  validates_format_of :email, with: EMAIL_REGEXP

  has_secure_password

  before_create do |user|
    user.confirmation_token = SecureRandom.urlsafe_base64
  end

  def confirm!
    return if confirmed?

    self.confirmed_at = Time.current
    self.confirmation_token = ''

    save!
  end

  def confirmed?
    confirmed_at.present?
  end

  def self.authenticate(email, password)
    user = confirmed.find_by(email: email).try(:authenticate, password)
  end

end
