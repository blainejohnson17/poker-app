require 'rails_helper'

describe Game, type: :model do
  it { should have_many(:hands) }

  it 'should update winner' do
    player1 = Player.create(name: "John")
    player2 = Player.create(name: "Jane")
    high_rank_hand = player1.hands.create(card_codes: %w[TC JC QC KC AC])
    low_rank_hand = player2.hands.create(card_codes: %w[2C 5D AH 9C KH])
    hands = [high_rank_hand, low_rank_hand]
    game = Game.new(hands: hands)
    expect {
      game.save
    }.to change { high_rank_hand.winner }.from(false).to(true)
  end
end