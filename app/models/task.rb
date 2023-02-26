class Task < ApplicationRecord
  include Tokenizable

  has_many :runs, dependent: :destroy
end
