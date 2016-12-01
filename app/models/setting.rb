class Setting < ApplicationRecord
  validates :key, presence: true
  validates_uniqueness_of :key
end
