extends Control

@onready var valor_colec = %Label2
@onready var colec = %Label

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func set_ui():
	valor_colec.text = "coleção vale: " + str(PlayerData.current_collection_value) + " moedas"
	
	var collect_txt = ""
	for i in PlayerData.current_collection:
		collect_txt = collect_txt + i + "\n"
	
	colec.text = collect_txt

#signals

func _on_button_button_down() -> void:
	GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.GACHA_ROOM]))
