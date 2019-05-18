module Escape
  class Room
    def initialize
      @player = Player.new
      @camera = Camera.new(@player)
    end

    def update
      @player.update
      @camera.update
    end

    def draw
      @camera.begin_3d_mode

      LibRay.draw_grid(100, 1)

      @player.draw

      LibRay.end_3d_mode
    end
  end
end
