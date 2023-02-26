class Run < ApplicationRecord
  include AASM

  belongs_to :task

  aasm timestamps: true, column: "state" do
    state :created, initial: true
    state :started
    state :finished
    state :canceled

    event :start do
      transitions from: :created, to: :started
    end

    event :finish do
      transitions from: :started, to: :finished
    end

    event :cancel do
      transitions from: [:created, :started], to: :canceled
    end
  end

  after_update_commit -> { broadcast_replace_to "run" }

  def duration
    if started_at
      (finished_at || canceled_at || Time.now) - started_at
    else
      0
    end
  end
end
