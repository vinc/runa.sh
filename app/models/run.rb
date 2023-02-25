class Run < ApplicationRecord
  include AASM

  belongs_to :task

  aasm column: "state" do
    state :waiting, initial: true
    state :running
    state :finished
    state :canceled

    event :start do
      transitions from: :waiting, to: :running
    end

    event :finish do
      transitions from: :running, to: :finished
    end

    event :cancel do
      transitions from: :running, to: :canceled
    end
  end
end
