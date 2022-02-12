# frozen_string_literal: true

class Ai < Player
  include Validation

  validate :name, :presence
  validate :name, :format, FORMAT_NAME
  validate :hold, :format, FORMAT_HOLD

  def make_choice
    return 'take card' if calc_cards < hold
    return 'pass' if calc_cards >= hold
  end
end
