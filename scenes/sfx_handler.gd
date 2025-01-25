extends Node2D

func try_to_play_sfx(sfx):
	for i in get_children():
		if i.playing == false:
			i.stream = sfx
			i.play()
			return
			
	print("!ALL SFX PLAYERS ARE BUSY!")
