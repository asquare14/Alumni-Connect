class ExpertiseUser < ApplicationRecord
  belongs_to :user
  belongs_to :expertise
end
