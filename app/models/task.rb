class Task < ApplicationRecord
  has_many :runs, dependent: :destroy

  validates :name, presence: true
  validates :input, presence: true

  before_create :set_uuid

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def to_param
    uuid
  end
end
