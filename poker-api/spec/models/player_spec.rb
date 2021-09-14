require 'rails_helper'

describe Player, type: :model do
  it { should have_many(:hands) }
end