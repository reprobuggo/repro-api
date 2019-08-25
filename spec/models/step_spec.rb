require 'rails_helper'

RSpec.describe Step, type: :model do
   # Association test
  # ensure an step record belongs to a single bug record
  it { should belong_to(:bug) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end