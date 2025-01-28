extends Node

const MUSICS = {
	"INTRO" : "res://resources/musics/intro.mp3",
	"TITLE" : "res://resources/musics/FROG MENU 2.mp3",
	"GACHA" : "res://resources/musics/froggyv2.mp3",
	"COLLECTION" : "res://resources/musics/frog market.mp3",
	"MARKET" : "res://resources/musics/Bolsa de Valores.mp3"
}

const SFX = {
	"BOOTUP" : "res://resources/sfx/frogbootup.mp3",
	"GACHA_SPIN" : "res://resources/sfx/gachabuy.mp3",
	"FROG_SELL" : "res://resources/sfx/frogsell.mp3",
	"IMPACT" : "res://resources/sfx/undertaleimpact.mp3",
	"DAMP_CLICK" : "res://resources/sfx/waterclick.mp3",
	"BUBBLE_CLICK" : "res://resources/sfx/bubbleclick3.mp3"
}

func get_resource(res):
	return(load(res))
