class Service < ApplicationRecord
  belongs_to :service_type
  belongs_to :client

  before_save :adjust_suspended

  def adjust_suspended
    if (self.suspended.present? && !self.suspended_at.present?)
      self.suspended_at = Time.now
    end
    if (!self.suspended.present?)
      self.suspended_at = nil
    end
  end
end
