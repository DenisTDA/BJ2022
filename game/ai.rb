# frozen_string_literal: true

class Ai < Player
  include Validation

  validate :name, :presence
  validate :name, :format, FORMAT_NAME
  validate :hold, :format, FORMAT_HOLD

  def make_choice
    return :choice_take if calc_cards < hold
    return :choice_pass if calc_cards >= hold
  end
end
