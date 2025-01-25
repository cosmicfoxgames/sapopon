extends Control

@onready var upper_ui = %upper_ui_collection

func _ready() -> void:
	print(PlayerData.current_collection)
	GameData.get_collection_value()
	upper_ui.set_ui()


func _process(delta: float) -> void:
	pass
