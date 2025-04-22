extends AudioStreamPlayer

@export var world : PackedScene


func _process(delta: float) -> void:
	if get_tree().current_scene == world:
		self.play()
