class ServiceType < ApplicationRecord
  validates :name, presence: true

  has_many :services, dependent: :destroy
end
