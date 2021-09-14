player_1 = Player.find_or_create_by(name: "Pocket Rockets")
player_2 = Player.find_or_create_by(name: "Big Slick")

seed_file = File.read(Rails.root.join('db', 'poker.txt'))

seed_file.each_line do |line|
  card_codes = line.split(" ")

  Game.create!(
    hands: [
      Hand.new(player: player_1, card_codes: card_codes[0..4]),
      Hand.new(player: player_2, card_codes: card_codes[5..9])
    ]
  )
end