require_relative 'entity'
require_relative '../../../lib/imperium'


class Npc < Imperium::GameEntity::Entity

  def initialize(x, y, type, name, properties)
    super(x, y, type, name, properties)
  end

end