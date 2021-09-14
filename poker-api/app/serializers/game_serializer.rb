class GameSerializer
  include FastJsonapi::ObjectSerializer
  has_many :hands
end
