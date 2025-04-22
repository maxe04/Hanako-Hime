extends Control

@export var cutscene :PackedScene
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(cutscene)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_start_button_mouse_entered() -> void:
	audio_stream_player.play()


func _on_quit_button_mouse_entered() -> void:
	audio_stream_player.play()
