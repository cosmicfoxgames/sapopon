extends Control

@onready var all_scenes = %all_scenes_here

func _ready() -> void:
	handle_changing_scene(load(GameData.scene_paths[GameData.SCENES.MAIN_MENU]))
	conect_all_signals()

func _process(delta: float) -> void:
	pass

func conect_all_signals():
	GlobalSignals.change_scene.connect(_on_change_scene)

func handle_changing_scene(scene_to_go : PackedScene):
	for i in all_scenes.get_children():
		i.queue_free()
	
	var new_scene = scene_to_go.instantiate()
	all_scenes.add_child(new_scene)

#signals

func _on_change_scene(scene : PackedScene):
	handle_changing_scene(scene)
