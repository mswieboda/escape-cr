module Escape
  class Camera
    property player : Player

    @distance : LibC::Float

    def initialize(@player)
      @distance = @player.height * 3
      @position = LibRay::Vector3.new(x: 0, y: @player.height * 1.25, z: 0)
      @up = LibRay::Vector3.new(x: 0, y: 1, z: 0)
      @fovy = 45
      @camera = LibRay::Camera.new
    end

    def update
      @position.z = @player.camera_target.z - @distance * Math.cos(@player.rotation * (Math::PI / 180.0))
      @position.x = @player.camera_target.x - @distance * Math.sin(@player.rotation * (Math::PI / 180.0))

      @camera = LibRay::Camera.new(
        position: @position,
        target: @player.camera_target,
        up: @up,
        fovy: @fovy
      )
    end

    def begin_3d_mode
      LibRay.begin_3d_mode(@camera)
    end
  end
end
