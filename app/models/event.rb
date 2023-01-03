class Event < ApplicationRecord
  belongs_to :place
  belongs_to :category

  validates :name, presence: true
end
