extends Control

@onready var upper_ui = %upper_ui_market

func _ready() -> void:
	upper_ui.set_ui()
	GlobalSignals.play_music.emit(GameResources.get_resource(GameResources.MUSICS["MARKET"]))

func _process(delta: float) -> void:
	pass
