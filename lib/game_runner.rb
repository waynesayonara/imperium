require_relative 'imperium'

$window = Imperium::ImperiumMain.new
$window.push_scene(Imperium::MenuScene.new(Imperium::DataModels::MenuSceneDataModelFactory.create_start_menu_data_model))
$window.show