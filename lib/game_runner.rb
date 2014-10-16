require_relative 'imperium'
require_relative '../lib/imperium/ui/scenes/implementations/menu_scene'

$window = Imperium::ImperiumMain.new
$window.push_scene(Imperium::MenuScene.new(Imperium::DataModels::MenuSceneDataModelFactory.create_start_menu_data_model))
$window.show