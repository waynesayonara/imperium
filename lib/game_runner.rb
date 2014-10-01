require_relative 'imperium'

$window = Imperium::ImperiumMain.new
$window.push_scene(Imperium::GameScene.new(Imperium::Game.load_game_from_map(Imperium::Map::TEST_PATH)))
$window.push_scene(Imperium::MenuScene.new(nil))
$window.show