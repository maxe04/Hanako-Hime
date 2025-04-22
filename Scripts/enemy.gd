extends CharacterBody3D


const SPEED = 5.0
@onready var scream: AudioStreamPlayer3D = $scream
@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var hurtbox: Area3D = $hurtbox

@onready var player = get_node("/root/World/Player")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	sprite_3d.visible = true
	hurtbox.monitoring = true



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := global_position.direction_to(player.global_position)
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

	move_and_slide()
	


func _on_hurtbox_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Global.score = 0
		get_tree().call_deferred("reload_current_scene")
		
		
func death():
	animation_player.play("death")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Global.score += 1
