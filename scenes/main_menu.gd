extends Control

@onready var all_scenes = %all_scenes_here

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

#signals

func _on_button_button_down() -> void:
	#GameData.start_fresh_game()
	GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.GACHA_ROOM]))
