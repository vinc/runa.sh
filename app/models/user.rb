class User < ApplicationRecord
  include AASM

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

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
end
