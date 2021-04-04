class Game < ApplicationRecord
  serialize :answered_positions, Array
  has_many :tasks, dependent: :delete_all
end