class Rover
  attr_accessor :facing, :x, :y
  attr_reader :id, :grid, :store

  COMMANDS = {
      'f' => :move_forwards,
      'b' => :move_backwards,
      'l' => :turn_left,
      'r' => :turn_right
  }

  FORDWARD_MOVEMENTS = {
      south: :move_back_in_y,
      north: :advance_in_y,
      east: :advance_in_x,
      west: :move_back_in_x,
  }

  BACKWARD_MOVEMENTS = {
      south: :advance_in_y,
      north: :move_back_in_y,
      east: :move_back_in_x,
      west: :advance_in_x,
  }

  TURN_LEFT_MOVEMENTS = {
      north: :west,
      south: :east,
      east: :north,
      west: :south,
  }

  TURN_RIGHT_MOVEMENTS = {
      north: :east,
      south: :west,
      east: :south,
      west: :north,
  }

  def initialize(grid, params = {})
    @store  = get_store(params[:id]) || create_store(params)
    @x      = store.x
    @y      = store.y
    @facing = store.facing.to_sym
    @id     = store.id
    @grid   = grid
    grid.set(x, y, self)
  end

  def move_forwards(quantity = 1)
    send FORDWARD_MOVEMENTS[facing], quantity
    grid.set(x, y, self)
    persist!
  end

  def move_backwards(quantity = 1)
    send BACKWARD_MOVEMENTS[facing], quantity
    grid.set(x, y, self)
    persist!
  end

  def turn_left
    self.facing = TURN_LEFT_MOVEMENTS[facing]
    persist!
  end

  def turn_right
    self.facing = TURN_RIGHT_MOVEMENTS[facing]
    persist!
  end

  def move(command)
    command.chars.each do |char|
      send COMMANDS[char]
    end
  end

  def as_json(*args)
    {
        id: id,
        x: x,
        y: y,
        facing: facing
    }
  end

  private

  def get_store(id)
    RoverStore.find_by(id: id)
  end

  def create_store(params)
    params.delete :id
    RoverStore.create(params)
  end

  def persist!
    store.update_columns x: x, y: y, facing: facing
  end

  def advance_in_x(quantity)
    self.x = (self.x + quantity) % grid.length
  end

  def advance_in_y(quantity)
    self.y = (self.y - quantity) % grid.height
  end

  def move_back_in_x(quantity)
    self.x = (self.x - quantity) % grid.length
  end

  def move_back_in_y(quantity)
    self.y = (self.y + quantity) % grid.height
  end
end
