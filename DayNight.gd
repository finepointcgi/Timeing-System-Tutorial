extends WorldEnvironment

var offset = 20
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var colors = [
	Color8(247,103,7),
	Color8(171,171,174),
	Color8(255,255,255),
]
var sky_colors = [
	Color8(219,152,108),
	Color8(52,58,64),
	Color8(165,214,241),
]

var light
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_nodes_in_group("TimeManager")[0].connect("TimeMinHasChanged",self,"on_TimeMinHasChanged")
	light = $DirectionalLight
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_TimeMinHasChanged(time):
	var h = wrapf((float(time.hour) + (float(time.minute)/60)), 0, 24)
	var timeInDay = h / 24 * 100 + offset
	if timeInDay > 100:
		timeInDay -= 100
	setTimeOfDay(timeInDay)
	get_tree().get_nodes_in_group("hslider")[0].value = timeInDay
	print(time)
 
func _on_HSlider_value_changed(value):
	setTimeOfDay(value)
	
func setTimeOfDay(value):
	print(value)
	if value > 50:
		light.rotation_degrees = Vector3(value * .01 * 360,0,0)
		light.light_energy = 1
		environment.background_sky.sun_latitude = (value - 50) * 2 * .01 * 180
		if value > 90:
			var lightValue = (value - 90) /10
			light.light_color = colors[2].linear_interpolate(colors[0],lightValue)
			environment.background_sky.sky_top_color = sky_colors[2].linear_interpolate(sky_colors[0], lightValue)
			environment.background_sky.sky_horizon_color = sky_colors[2].linear_interpolate(sky_colors[1], lightValue)
		elif value < 60:
			var lightValue = (value - 60)/10 * -1
			light.light_color = colors[2].linear_interpolate(colors[0],lightValue)
			environment.background_sky.sky_top_color = sky_colors[2].linear_interpolate(sky_colors[0], lightValue)
			environment.background_sky.sky_horizon_color = sky_colors[2].linear_interpolate(sky_colors[1], lightValue)
			
		else:
			light.light_color = colors[2]
	elif value < 50:
		environment.background_sky.sun_latitude = value * 2 * .01 * 180
		light.rotation_degrees = Vector3(value * .01 * 360 * -1, 180,0)
		light.light_energy = .2
		light.light_color = colors[1]
		environment.background_sky.sky_top_color = sky_colors[1]
		environment.background_sky.sky_horizon_color = sky_colors[1]
		
	pass # Replace with function body.
