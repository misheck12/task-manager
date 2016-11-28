class Task < ApplicationRecord
  COLOR_REGEXP = /#[0-9A-F]{6}/i

  belongs_to :user
  belongs_to :client

  before_save :adjust_done

  validates :when, :duration, :activity, :color, presence: true
  validates :activity, length: {minimum: 3, maximum: 128}
  validates_format_of :color, with: COLOR_REGEXP

  scope :user, ->(id) { where(:user_id => id) }
  scope :past, -> { where(:when => (DateTime.now - 20.years)..(DateTime.now)) }
  scope :next_year, -> { where(:when => (DateTime.now - 3.months)..(DateTime.now + 12.months)) }
  scope :last_year, -> { where(:when => (DateTime.now - 12.months)..(DateTime.now + 1.minute)) }
  scope :next_semester, -> { where(:when => (DateTime.now - 1.months)..(DateTime.now + 6.months)) }
  scope :last_week, -> { where(:when => (DateTime.now - 1.week)..(DateTime.now + 1.minute)) }
  scope :next_week, -> { where(:when => (DateTime.now - 1.minute)..(DateTime.now + 1.week)) }
  scope :done, -> { where(:done => 1) }
  scope :pending, -> { where.not(:done => 1) }
  scope :old_first, -> { order(when: :asc) }

  def adjust_done
    if (self.done.present? && !self.done_at.present?)
      self.done_at = Time.now
    end
    if (!self.done.present?)
      self.done_at = nil
    end
  end

  def self.status(id)
    if (find(id).done.present?)
      return 'done'
    end

    (find(id).when < DateTime.now) ? 'late' : 'to_do'
  end
end