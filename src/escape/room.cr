module Escape
  class Room
    def initialize
      @player = Player.new
      @camera = Camera.new(@player)
      @door = Door.new
    end

    def update
      @player.update
      @camera.update
      @door.update
    end

    def draw
      @camera.begin_3d_mode

      LibRay.draw_grid(100, 1)

      @player.draw

      @door.draw

      LibRay.end_3d_mode
    end
  end
end
