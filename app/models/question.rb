class Question < ApplicationRecord
  belongs_to :user
  has_one :answer, dependent: :destroy

  accepts_nested_attributes_for :answer, allow_destroy: true

  validates :level, :category, :statement, :prop_one, :prop_two, :prop_three, presence: true
  validates :statement, length: { minimum: 2}
  validates :prop_one, length: { minimum: 2}
  validates :prop_two, length: { minimum: 2}
  validates :prop_three, length: { minimum: 2}

  enum level: { départemental: 1, régional: 2 }
  enum category: { généralités: 1, fleuret: 2, épée: 3, sabre: 4 }

  scope :dep_g, -> { where(level: 1).where(category: 1)}
  scope :dep_f, -> { where(level: 1).where(category: 2)}
  scope :dep_e, -> { where(level: 1).where(category: 3)}
  scope :dep_s, -> { where(level: 1).where(category: 4)}
  scope :reg_g, -> { where(level: 2).where(category: 1)}
  scope :reg_f, -> { where(level: 2).where(category: 2)}
  scope :reg_e, -> { where(level: 2).where(category: 3)}
  scope :reg_s, -> { where(level: 2).where(category: 4)}

  def self.filter_by_level(level)
    where(level: level)
  end

  def self.filter_by_category(category)
    where(category: category)
  end

end
