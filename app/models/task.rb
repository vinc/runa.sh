class Task < ApplicationRecord
  has_many :runs, dependent: :destroy
end
