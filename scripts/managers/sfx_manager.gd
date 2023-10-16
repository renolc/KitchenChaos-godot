class_name SfxManager
extends AudioStreamPlayer3D

@export var sfxs: Array[AudioStream]

func play_random():
	stream = sfxs.pick_random()
	play()
