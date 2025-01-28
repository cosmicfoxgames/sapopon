extends Control

@onready var valor_colec = %Label2
@onready var colec = %Label
@onready var grid = %GridContainer

@export var frog_icon : PackedScene

func _ready() -> void:
	set_frog_grid()

func _process(delta: float) -> void:
	pass

func set_frog_grid():
	for i in PlayerData.current_collection:
		var new_frog_icon = frog_icon.instantiate()
		grid.add_child(new_frog_icon)
		new_frog_icon.set_itself(load(GameData.FROG_TEMPLATE_PATH % i))

func set_ui():
	valor_colec.text = tr("collection_value") % str(PlayerData.current_collection_value)
	
	var collect_txt = ""
	for i in PlayerData.current_collection:
		collect_txt = collect_txt + i + "\n"
	
	colec.text = collect_txt

#signals

func _on_button_button_down() -> void:
	GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.GACHA_ROOM]))
