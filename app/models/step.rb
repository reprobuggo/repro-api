# app/models/step.rb
class Step < ApplicationRecord
  # model association
  belongs_to :bug

  # validation
  validates_presence_of :name
end