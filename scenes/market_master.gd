extends Control

@onready var upper_ui = %upper_ui_market

func _ready() -> void:
	upper_ui.set_ui()

func _process(delta: float) -> void:
	pass
