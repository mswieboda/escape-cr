module Escape
  class Game
    SCREEN_WIDTH  = 1024
    SCREEN_HEIGHT =  768

    DEBUG = false

    TARGET_FPS = 60
    DRAW_FPS   = DEBUG

    def initialize
      LibRay.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "Escape")
      LibRay.set_target_fps(TARGET_FPS)
      @room = Room.new
    end

    def run
      while !LibRay.window_should_close?
        update
        draw_init
      end

      close
    end

    def update
      @room.update
    end

    def draw
      @room.draw

      LibRay.draw_fps(0, 0) if DRAW_FPS
    end

    def draw_init
      LibRay.begin_drawing
      LibRay.clear_background LibRay::BLACK

      draw

      LibRay.end_drawing
    end

    def close
      LibRay.close_window
    end
  end
end
