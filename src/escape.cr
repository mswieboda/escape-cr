require "cray"
require "./escape/*"

module Escape
  def self.run
    Game.new.run
  end
end

Escape.run
