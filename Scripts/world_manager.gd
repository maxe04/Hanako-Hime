extends Node

@onready var path_follow_3d: PathFollow3D = $"../Path3D/PathFollow3D"
@onready var spawn_timer: Timer = $"../spawnTimer"
var enemy = preload("res://Scenes/enemy.tscn")
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"


func _ready():
	spawn_timer.start()
	animation_player.play("start")
	
	
func spawn_enemy():
	path_follow_3d.progress_ratio = randf()
	var new_enemy = enemy.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = path_follow_3d.global_position
	


func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
