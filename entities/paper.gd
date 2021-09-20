extends Control

const RADIUS: float = 50.0
const HALF_RADIUS: float = RADIUS / 2

const KEY_COUNT: int = 9

onready var sprite = $Sprite
onready var circle: Node2D = $Circle
var should_toggle_off := false

var viewport: Viewport

var height: int
var width: int

var counter: Vector2 = Vector2.ZERO
var x_counter: float = 0.0
var y_counter: float = 0.0

var current_color: Color = Color(1.0, 1.0, 1.0, 0.5)

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	viewport = get_viewport()
	height = viewport.size.y
	width = viewport.size.x
	
	counter.x = HALF_RADIUS
	counter.y = HALF_RADIUS
	
	circle.color = current_color
	circle.radius = RADIUS

func _process(delta: float) -> void:
	
	circle.draw_position = counter
	if circle.visible:
		if should_toggle_off:
			circle.visible = false
			should_toggle_off = false
		else:
			should_toggle_off = true

func _unhandled_key_input(event: InputEventKey):
	if (not event.pressed or event.echo):
		return
	var value: float = ((event.scancode as float) / 100.0)
	
	match event.scancode:
		KEY_Q:
			current_color = current_color.from_hsv(0, 0.75, 0.75, 0.5)
		KEY_W:
			current_color = current_color.from_hsv(1.0 / KEY_COUNT, 0.75, 0.75, 0.5)
		KEY_E:
			current_color = current_color.from_hsv(2.0 / KEY_COUNT, 0.75, 0.75, 0.5)
		KEY_R:
			current_color = current_color.from_hsv(3.0 / KEY_COUNT, 0.75, 0.75, 0.5)
		KEY_T:
			current_color = current_color.from_hsv(4.0 / KEY_COUNT, 0.75, 0.75, 0.5)
		KEY_Y:
			current_color = current_color.from_hsv(5.0 / KEY_COUNT, 0.75, 0.75, 0.5)
		KEY_U:
			current_color = current_color.from_hsv(6.0 / KEY_COUNT, 0.75, 0.75, 0.5)
		KEY_I:
			current_color = current_color.from_hsv(7.0 / KEY_COUNT, 0.75, 0.75, 0.5)
		KEY_O:
			current_color = current_color.from_hsv(8.0 / KEY_COUNT, 0.75, 0.75, 0.5)
		KEY_P:
			current_color = current_color.from_hsv(0.0, 0.0, 1.0, 0.5)
	
	print(current_color)
	
#	current_color.a = 0.5
#	current_color = current_color.from_hsv(value, 0.75, 0.75, 0.5)
	
	circle.visible = true
	circle.color = current_color
	circle.update()
	
	counter.x += HALF_RADIUS
	if counter.x > width:
		counter.x = 0.0
		counter.y += HALF_RADIUS
		if counter.y > height:
			counter.y = 0.0

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################
