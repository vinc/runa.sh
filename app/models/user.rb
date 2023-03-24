class User < ApplicationRecord
  include AASM

  before_create :set_api_key

  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  devise :registerable if ENV["RUNA_ALLOW_SIGNUP"] == "true"

  has_many :tasks, dependent: :destroy
  has_many :runs, through: :tasks

  aasm column: "state" do
    state :disabled, initial: true
    state :enabled

    event :enable do
      transitions from: :disabled, to: :enabled
    end

    event :disable do
      transitions from: :enabled, to: :disabled
    end
  end

  def set_api_key
    self.api_key = SecureRandom.hex(64)
  end
end
