class Expertise < ApplicationRecord
    has_and_belongs_to_many :users, dependent: :destroy
    has_many :expertise_users
    has_many :users, through: :expertise_users
end
