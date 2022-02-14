# frozen_string_literal: true

require_relative 'validation'
class Player
  include Validation

  BANK = 100
  BID = 10
  BJ = 21
  T = 11
  T_1 = 1
  FORMAT_NAME = /[a-zа-я]{3,}/i.freeze
  FORMAT_HOLD = /^(1[0-9])|2[0-1]$/.freeze

  validate :name, :presence
  validate :name, :format, FORMAT_NAME
  validate :hold, :format, FORMAT_HOLD

  attr_accessor :bank, :cards
  attr_reader :hold, :name

  def initialize(name, hold = 17)
    @name = name
    @hold = hold
    @bank = BANK
    @cards = []
    validate!
  end

  def make_bid
    if BID > bank
      'Not enouhg mony!'
    else
      self.bank -= BID
      BID
    end
  end

  def take_bank(win_bank)
    self.bank += win_bank
  end

  def take_card(card)
    cards.append(card)
  end

  def calc_cards
    summ = 0
    values = []
    cards.each { |card| values << card.value }
    values.sort.each do |value|
      if value == T
        value = (summ + T) <= BJ ? T : T_1
      end
      summ += value
    end
    summ
  end

  def open_cards
    cards.each(&:opened)
  end

  def close_cards
    cards.each(&:closed)
  end

  def cards_reset
    self.cards = []
  end

  def pass
    p "#{name} - PASS!!!"
  end
end
