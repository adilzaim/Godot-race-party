extends Control
@onready var line_edit: LineEdit = $HBoxContainer/LineEdit
var score = GlobalVariable.score
var player_name:String
var player_scores = GlobalVariable.player_scores

func _on_line_edit_text_submitted(new_text: String) -> void:
	player_name = line_edit.text
	GlobalVariable.player_name = new_text
	print(player_name)



func _on_score_pressed() -> void:
	GlobalVariable.score+=60
	score = GlobalVariable.score
	print(score)

func _on_submit_pressed() -> void:
	await Leaderboards.post_guest_score("scoreraces-scorerace-cW2t", score, player_name)
	get_tree().reload_current_scene()


func _on_button_pressed() -> void:
	$LeaderboardUI.hide()

func _on_load_board_b_pressed() -> void:
	$LeaderboardUI.show()
