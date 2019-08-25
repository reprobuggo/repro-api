# app/models/bug.rb
class Bug < ApplicationRecord
  # model association
  has_many :steps, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by
end
