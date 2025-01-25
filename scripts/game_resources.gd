extends Node

const MUSICS = {
	"FROGGO" : "res://resources/musics/froggy song.mp3"
}

const SFX = {
	"CROACK" : "res://resources/sfx/frog-39142.mp3"
}

func get_resource(res):
	return(load(res))
