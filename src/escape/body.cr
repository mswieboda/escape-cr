module Escape
  class Body
    getter height : LibC::Float
    getter rotation : LibC::Float

    def initialize
      @width = 0.48
      @height = 1.7
      @length = 0.17

      mesh = LibRay.gen_mesh_cube(
        width: @width,
        height: @height,
        # TODO: tell cray developer binding key "lenght" is typo:
        lenght: @length
      )
      @model = LibRay.load_model_from_mesh(mesh)

      @position = LibRay::Vector3.new(x: 0, y: 0, z: 0)
      @rotation = 0
    end

    def camera_target
      LibRay::Vector3.new(
        x: @position.x,
        y: @height / 2,
        z: @position.z
      )
    end

    def update(position, rotation)
      @position = position
      @rotation = rotation
    end

    def draw
      LibRay.draw_model_ex(
        model: @model,
        position: @position,
        rotation_axis: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        rotation_angle: @rotation,
        scale: LibRay::Vector3.new(x: 1, y: 1, z: 1),
        tint: LibRay::GREEN
      )
    end
  end
end
