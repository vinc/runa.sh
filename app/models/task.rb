class Task < ApplicationRecord
  has_many :runs, dependent: :destroy

  belongs_to :user

  enum :runner, [:run_xs, :run_sm, :run_md, :run_lg]

  validates :name, presence: true
  validates :input, presence: true
  validates :runner, presence: true

  before_create :set_uuid

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def to_param
    uuid
  end
end
