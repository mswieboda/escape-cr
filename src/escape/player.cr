module Escape
  class Player
    getter rotation : LibC::Float
    delegate height, to: @body

    FORWARD_SPEED  =   15
    STRAFE_SPEED   =   10
    ROTATION_SPEED =  100
    JUMP_SPEED     =  150
    JUMP_TIMER     = 0.25
    GRAVITY        =   10

    def initialize
      @body = Body.new
      @position = LibRay::Vector3.new(x: 0, y: height / 2.0, z: 0)
      @rotation = 0
      @jump_timer = Timer.new(JUMP_TIMER)
    end

    def camera_target
      LibRay::Vector3.new(
        x: @position.x,
        y: height / 2.0,
        z: @position.z
      )
    end

    def update
      frame_time = LibRay.get_frame_time

      movement(frame_time)
      jump(frame_time)
      gravity(frame_time)

      @body.update(@position, @rotation)
    end

    def movement(frame_time)
      rotation_movement(frame_time)
      forward_movement(frame_time)
      strafe_movement(frame_time)
    end

    def rotation_movement(frame_time)
      delta = 0

      delta = 1 if LibRay.key_down?(LibRay::KEY_Q)
      delta = -1 if LibRay.key_down?(LibRay::KEY_E)

      @rotation += ROTATION_SPEED * delta * frame_time if delta != 0
    end

    def forward_movement(frame_time)
      delta = 0

      delta = 1 if LibRay.key_down?(LibRay::KEY_UP) || LibRay.key_down?(LibRay::KEY_W)
      delta = -1 if LibRay.key_down?(LibRay::KEY_DOWN) || LibRay.key_down?(LibRay::KEY_S)

      if delta != 0
        distance = FORWARD_SPEED * delta * frame_time

        @position.z += distance * Math.cos(@rotation * (Math::PI / 180.0))
        @position.x += distance * Math.sin(@rotation * (Math::PI / 180.0))
      end
    end

    def strafe_movement(frame_time)
      delta = 0

      delta = 1 if LibRay.key_down?(LibRay::KEY_LEFT) || LibRay.key_down?(LibRay::KEY_A)
      delta = -1 if LibRay.key_down?(LibRay::KEY_RIGHT) || LibRay.key_down?(LibRay::KEY_D)

      if delta != 0
        distance = STRAFE_SPEED * delta.abs * frame_time
        angle_with_strafe = (@rotation + delta * 90)

        @position.z += distance * Math.cos(angle_with_strafe * (Math::PI / 180.0))
        @position.x += distance * Math.sin(angle_with_strafe * (Math::PI / 180.0))
      end
    end

    def jump(frame_time)
      @jump_timer.restart if grounded? && !@jump_timer.active? && LibRay.key_pressed?(LibRay::KEY_SPACE)

      if @jump_timer.active?
        @jump_timer.increase(frame_time)
        @position.y += JUMP_SPEED * frame_time

        @jump_timer.reset if @jump_timer.done?
      end
    end

    def gravity(frame_time)
      if grounded?
        @position.y = height / 2.0
      else
        @position.y -= GRAVITY * GRAVITY * frame_time
      end
    end

    def grounded?
      @position.y < height / 2.0 + 0.1
    end

    def draw
      @body.draw
    end
  end
end
