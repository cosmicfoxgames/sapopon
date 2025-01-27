extends Control

@onready var all_scenes = %all_scenes_here

func _ready() -> void:
	GlobalSignals.play_music.emit(load("res://resources/muics/frog market.mp3"))

func _process(delta: float) -> void:
	pass

#signals

#newgame
func _on_button_button_down() -> void:
	GameData.start_fresh_game()
	GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.DESKTOP]))
	
	GlobalSignals.play_sfx.emit(load("res://resources/sfx/frogbootup.mp3"))

#credits
func _on_button_2_button_down() -> void:
	pass # Replace with function body.

#exit
func _on_button_3_button_down() -> void:
	get_tree().quit()
