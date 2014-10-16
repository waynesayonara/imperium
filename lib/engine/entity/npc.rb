require_relative 'entity'


class Npc < Engine::GameEntity::Entity

  def initialize(x, y, type, name, properties)
    super(x, y, type, name, properties)
  end

end