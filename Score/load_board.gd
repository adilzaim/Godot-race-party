extends Control
@onready var line_edit: LineEdit = $HBoxContainer/LineEdit



func _on_button_pressed() -> void:
	$LeaderboardUI.hide()

func _on_load_board_b_pressed() -> void:
	$LeaderboardUI.show()
	
