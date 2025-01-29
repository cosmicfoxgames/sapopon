extends Control

@onready var all_scenes = %all_scenes_here

func _ready() -> void:
	GlobalSignals.stop_music.emit()
	GlobalSignals.play_sfx.emit(GameResources.get_random_frog_ribbit())

func _process(delta: float) -> void:
	pass

#signals

func _on_butt_log_in_button_click() -> void:
	GameData.start_fresh_game()
	GlobalSignals.fade_scene.emit(load(GameData.scene_paths[GameData.SCENES.DESKTOP]))
func _on_butt_log_out_button_click() -> void:
	get_tree().quit()
