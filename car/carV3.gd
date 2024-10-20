extends VehicleBody3D


var max_rpm = 500
var max_torque = 200

func _physics_process(delta: float) -> void:
	steering = lerp(steering,Input.get_axis("ui_right","ui_left") * 0.4, 5*delta )
	var acceleration = Input.get_axis("ui_down","ui_up") 
	var rpm = $back_left.get_rpm()
	$back_left.engine_force =  acceleration * max_torque*(1- rpm / max_rpm)
	rpm =$back_right.get_rpm()
	$back_right.engine_force =  acceleration * max_torque*(1- rpm / max_rpm)
