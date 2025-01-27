extends Control

@onready var all_scenes = %all_scenes_here

func _ready() -> void:
	GlobalSignals.stop_music.emit()
	GlobalSignals.play_sfx.emit(GameResources.get_resource(GameResources.SFX["BOOTUP"]))

func _process(delta: float) -> void:
	pass

#signals

#newgame
func _on_button_button_down() -> void:
	GameData.start_fresh_game()
	GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.DESKTOP]))

#credits
func _on_button_2_button_down() -> void:
	pass # Replace with function body.

#exit
func _on_button_3_button_down() -> void:
	get_tree().quit()
