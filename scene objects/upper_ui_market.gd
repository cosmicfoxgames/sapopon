extends Control

@onready var board = %Label

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func set_ui():
	var text_to_set = "Flutuação de hoje\n\nColeções em positivo:\n"
	
	for i in PlayerData.today_market_fluctuation[0]:
		if i == PlayerData.today_market_fluctuation[2][0] or i == PlayerData.today_market_fluctuation[2][1]:
			text_to_set = text_to_set + i + " !SUPER!\n"
		else: text_to_set = text_to_set + i + "\n"
	
	text_to_set = text_to_set + "\nColeções em negativo:\n"
	
	for i in PlayerData.today_market_fluctuation[1]:
		if i == PlayerData.today_market_fluctuation[2][0] or i == PlayerData.today_market_fluctuation[2][1]:
			text_to_set = text_to_set + i + " !SUPER!\n"
		else: text_to_set = text_to_set + i + "\n"
	
	board.text = text_to_set

#signals

func _on_button_2_button_down() -> void:
	GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.GACHA_ROOM]))
