class Task < ApplicationRecord
  has_many :runs, dependent: :destroy

  belongs_to :user

  enum :runner, [:xs, :sm, :md, :lg]

  def self.runner_labels
    {
      xs: "1 CPU + 1GB RAM",
      sm: "2 CPU + 2GB RAM",
      md: "4 CPU + 4GB RAM",
      lg: "8 CPU + 8GB RAM"
    }
  end

  validates :name, presence: true
  validates :script, presence: true
  validates :runner, presence: true

  before_create :set_uuid

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def to_param
    uuid
  end
end
