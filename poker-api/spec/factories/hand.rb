FactoryBot.define do
  factory :hand do
    game
    player
    card_codes { %w[TC JC QC KC AC] }
  end
end
