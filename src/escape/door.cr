module Escape
  class Door
    def initialize
      @width = 3
      @height = 7
      @length = 0.5

      mesh = LibRay.gen_mesh_cube(
        width: @width,
        height: @height,
        # TODO: tell cray developer binding key "lenght" is typo:
        lenght: @length
      )
      @model = LibRay.load_model_from_mesh(mesh)

      @position = LibRay::Vector3.new(x: 10, y: @height / 2.0, z: 10)
      @rotation = 0
    end

    def update
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
