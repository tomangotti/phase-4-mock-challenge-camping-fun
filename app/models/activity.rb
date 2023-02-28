class Activity < ApplicationRecord
    has_many :signups, dependent: :destroy
    has_many :campers, through: :signups

    validates :name, presence: true
end
