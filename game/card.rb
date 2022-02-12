# frozen_string_literal: true

class Card
  attr_accessor :suit, :rank, :value, :status

  def initialize(suit, rank, value)
    @suit = suit
    @rank = rank
    @value = value
    @status = false
  end

  def opened
    self.status = true
  end

  def closed
    self.status = false
  end

  def opened?
    status
  end
end
