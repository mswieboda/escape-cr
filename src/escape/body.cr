module Escape
  class Body
    getter height : LibC::Float
    getter rotation : LibC::Float

    @tint : LibRay::Color
    @head_height : LibC::Float
    @body_height : LibC::Float
    @leg_height : LibC::Float
    @leg_width : LibC::Float

    def initialize
      @width = 0.48
      @height = 1.7
      @length = 0.17
      @position = LibRay::Vector3.new
      @rotation = 0
      @tint = LibRay::GREEN

      # head
      @head_height = @height * 0.125
      mesh = LibRay.gen_mesh_sphere(
        radius: @height * 0.117,
        rings: 10,
        slices: 10
      )
      @head_model = LibRay.load_model_from_mesh(mesh)

      # body
      @body_height = @height * 0.41
      mesh = LibRay.gen_mesh_cube(
        width: @width,
        height: @body_height,
        lenght: @length
      )
      @body_model = LibRay.load_model_from_mesh(mesh)

      # leg
      @leg_height = @height * 0.41
      @leg_width = (@width / 3.0).to_f32
      mesh = LibRay.gen_mesh_cube(
        width: @leg_width,
        height: @leg_height,
        lenght: @length
      )
      @leg_model = LibRay.load_model_from_mesh(mesh)
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
      # head
      LibRay.draw_model_ex(
        model: @head_model,
        position: LibRay::Vector3.new(x: @position.x, y: @position.y + @body_height / 2.0 + @head_height / 2.0, z: @position.z),
        rotation_axis: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        rotation_angle: @rotation,
        scale: LibRay::Vector3.new(x: 1, y: 1, z: 1),
        tint: @tint
      )
      LibRay.draw_model_wires_ex(
        model: @head_model,
        position: LibRay::Vector3.new(x: @position.x, y: @position.y + @body_height / 2.0 + @head_height / 2.0, z: @position.z),
        rotation_axis: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        rotation_angle: @rotation,
        scale: LibRay::Vector3.new(x: 1, y: 1, z: 1),
        tint: LibRay::WHITE
      )

      # body
      LibRay.draw_model_ex(
        model: @body_model,
        position: LibRay::Vector3.new(x: @position.x, y: @position.y, z: @position.z),
        rotation_axis: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        rotation_angle: @rotation,
        scale: LibRay::Vector3.new(x: 1, y: 1, z: 1),
        tint: @tint
      )
      LibRay.draw_model_wires_ex(
        model: @body_model,
        position: LibRay::Vector3.new(x: @position.x, y: @position.y, z: @position.z),
        rotation_axis: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        rotation_angle: @rotation,
        scale: LibRay::Vector3.new(x: 1, y: 1, z: 1),
        tint: LibRay::WHITE
      )

      # legs
      # left leg
      LibRay.draw_model_ex(
        model: @leg_model,
        position: LibRay::Vector3.new(
          x: @position.x + @leg_width * Math.sin((@rotation + 90) * (Math::PI / 180.0)),
          y: @position.y - @body_height / 2.0 - @leg_height / 2.0,
          z: @position.z + @leg_width * Math.cos((@rotation + 90) * (Math::PI / 180.0))
        ),
        rotation_axis: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        rotation_angle: @rotation,
        scale: LibRay::Vector3.new(x: 1, y: 1, z: 1),
        tint: @tint
      )
      LibRay.draw_model_wires_ex(
        model: @leg_model,
        position: LibRay::Vector3.new(
          x: @position.x + @leg_width * Math.sin((@rotation + 90) * (Math::PI / 180.0)),
          y: @position.y - @body_height / 2.0 - @leg_height / 2.0,
          z: @position.z + @leg_width * Math.cos((@rotation + 90) * (Math::PI / 180.0))
        ),
        rotation_axis: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        rotation_angle: @rotation,
        scale: LibRay::Vector3.new(x: 1, y: 1, z: 1),
        tint: LibRay::WHITE
      )

      # right leg
      LibRay.draw_model_ex(
        model: @leg_model,
        position: LibRay::Vector3.new(
          x: @position.x + @leg_width * Math.sin((@rotation - 90) * (Math::PI / 180.0)),
          y: @position.y - @body_height / 2.0 - @leg_height / 2.0,
          z: @position.z + @leg_width * Math.cos((@rotation - 90) * (Math::PI / 180.0))
        ),
        rotation_axis: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        rotation_angle: @rotation,
        scale: LibRay::Vector3.new(x: 1, y: 1, z: 1),
        tint: @tint
      )
      LibRay.draw_model_wires_ex(
        model: @leg_model,
        position: LibRay::Vector3.new(
          x: @position.x + @leg_width * Math.sin((@rotation - 90) * (Math::PI / 180.0)),
          y: @position.y - @body_height / 2.0 - @leg_height / 2.0,
          z: @position.z + @leg_width * Math.cos((@rotation - 90) * (Math::PI / 180.0))
        ),
        rotation_axis: LibRay::Vector3.new(x: 0, y: 1, z: 0),
        rotation_angle: @rotation,
        scale: LibRay::Vector3.new(x: 1, y: 1, z: 1),
        tint: LibRay::WHITE
      )
    end
  end
end
