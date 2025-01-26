extends Node

func clicked_on_button(which):
	match which:
		"market" : GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.MARKET]))
		"collection" : GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.COLLECTION]))
		"gacha" : GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.GACHA_ROOM]))
