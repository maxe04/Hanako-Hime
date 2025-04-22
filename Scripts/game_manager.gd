extends Node
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

@export var world:PackedScene

func _ready():
	animation_player.play("Chapter_1")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED )
	



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_packed(world)
