extends Control

signal gacha_got_new_frog

func _on_gacha_got_new_frog() -> void:
	gacha_got_new_frog.emit()
