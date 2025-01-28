extends Control

@onready var label = %Label
@onready var bar_texture = %bar

@export var good_bar : Resource
@export var xtra_good_bar : Resource
@export var bad_bar : Resource
@export var xtra_bad_bar : Resource

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func set_itself(stock : String, fluctuation : GameData.FLUCTUATION_RATE):
	label.text = stock
	match fluctuation:
		GameData.FLUCTUATION_RATE.XTRA_BAD: bar_texture.texture = xtra_bad_bar
		GameData.FLUCTUATION_RATE.BAD: bar_texture.texture = bad_bar
		GameData.FLUCTUATION_RATE.GOOD: bar_texture.texture = good_bar
		GameData.FLUCTUATION_RATE.XTRA_GOOD: bar_texture.texture = xtra_good_bar
