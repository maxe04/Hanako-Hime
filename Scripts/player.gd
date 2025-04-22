extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var player_camera: Camera3D = $PlayerCamera
@onready var animation: AnimationPlayer = $animation
@onready var hitbox: Area3D = $"PlayerCamera/WeaponPivot/tanjiro's katana/Hitbox"




func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * .002)
		player_camera.rotate_x(-event.relative.y * .002)
		player_camera.rotation.x = clamp(player_camera.rotation.x, -(PI/4), (PI/4))
		

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		animation.play("attack");
		hitbox.monitoring = true



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		animation.play("idle")
		hitbox.monitoring = false





func _on_hitbox_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemy"):
		body.death()
		
		
