extends Control

const RADIUS: float = 50.0
const HALF_RADIUS: float = RADIUS / 2

const KEY_COUNT: int = 9

const BASE_S: float = 0.75

const V_STEP_1: float = 1.0
const V_STEP_2: float = 0.6
const V_STEP_3: float = 0.3

const OPACTIY: float = 0.5

var color_layout: Dictionary

onready var sprite = $Sprite
onready var circle: Node2D = $Circle
var should_toggle_off := false

var viewport: Viewport

var height: int
var width: int

var counter: Vector2 = Vector2.ZERO
var x_counter: float = 0.0
var y_counter: float = 0.0

var current_color: Color = Color(1.0, 1.0, 1.0, OPACTIY)

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
	
	var col := Color()
	color_layout = {
		"q": col.from_hsv(0, BASE_S, V_STEP_1, OPACTIY), "a": col.from_hsv(0, BASE_S, V_STEP_2, OPACTIY), "z": col.from_hsv(0, BASE_S, V_STEP_3, OPACTIY),
		"w": col.from_hsv(1.0 / KEY_COUNT, BASE_S, V_STEP_1, OPACTIY), "s": col.from_hsv(1.0 / KEY_COUNT, BASE_S, V_STEP_2, OPACTIY), "x": col.from_hsv(1.0 / KEY_COUNT, BASE_S, V_STEP_3, OPACTIY),
		"e": col.from_hsv(2.0 / KEY_COUNT, BASE_S, V_STEP_1, OPACTIY), "d": col.from_hsv(2.0 / KEY_COUNT, BASE_S, V_STEP_2, OPACTIY), "c": col.from_hsv(2.0 / KEY_COUNT, BASE_S, V_STEP_3, OPACTIY),
		"r": col.from_hsv(3.0 / KEY_COUNT, BASE_S, V_STEP_1, OPACTIY), "f": col.from_hsv(3.0 / KEY_COUNT, BASE_S, V_STEP_2, OPACTIY), "v": col.from_hsv(3.0 / KEY_COUNT, BASE_S, V_STEP_3, OPACTIY),
		"t": col.from_hsv(4.0 / KEY_COUNT, BASE_S, V_STEP_1, OPACTIY), "g": col.from_hsv(4.0 / KEY_COUNT, BASE_S, V_STEP_2, OPACTIY), "b": col.from_hsv(4.0 / KEY_COUNT, BASE_S, V_STEP_3, OPACTIY),
		"y": col.from_hsv(5.0 / KEY_COUNT, BASE_S, V_STEP_1, OPACTIY), "h": col.from_hsv(5.0 / KEY_COUNT, BASE_S, V_STEP_2, OPACTIY), "n": col.from_hsv(5.0 / KEY_COUNT, BASE_S, V_STEP_3, OPACTIY),
		"u": col.from_hsv(6.0 / KEY_COUNT, BASE_S, V_STEP_1, OPACTIY), "j": col.from_hsv(6.0 / KEY_COUNT, BASE_S, V_STEP_2, OPACTIY), "m": col.from_hsv(6.0 / KEY_COUNT, BASE_S, V_STEP_3, OPACTIY),
		"i": col.from_hsv(7.0 / KEY_COUNT, BASE_S, V_STEP_1, OPACTIY), "k": col.from_hsv(7.0 / KEY_COUNT, BASE_S, V_STEP_2, OPACTIY), ",": col.from_hsv(7.0 / KEY_COUNT, BASE_S, V_STEP_3, OPACTIY),
		"o": col.from_hsv(8.0 / KEY_COUNT, BASE_S, V_STEP_1, OPACTIY), "l": col.from_hsv(8.0 / KEY_COUNT, BASE_S, V_STEP_2, OPACTIY), ".": col.from_hsv(8.0 / KEY_COUNT, BASE_S, V_STEP_3, OPACTIY),
		"p": col.from_hsv(0.0, 0.0, 1.0, OPACTIY), ";": col.from_hsv(0.0, 0.0, OPACTIY, OPACTIY), "/": col.from_hsv(0.0, 0.0, 0.0, OPACTIY)
	}

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
			current_color = color_layout.q
		KEY_W:
			current_color = color_layout.w
		KEY_E:
			current_color = color_layout.e
		KEY_R:
			current_color = color_layout.r
		KEY_T:
			current_color = color_layout.t
		KEY_Y:
			current_color = color_layout.y
		KEY_U:
			current_color = color_layout.u
		KEY_I:
			current_color = color_layout.i
		KEY_O:
			current_color = color_layout.o
		KEY_P:
			current_color = color_layout.p
		KEY_A:
			current_color = color_layout.a
		KEY_S:
			current_color = color_layout.s
		KEY_D:
			current_color = color_layout.d
		KEY_F:
			current_color = color_layout.f
		KEY_G:
			current_color = color_layout.g
		KEY_H:
			current_color = color_layout.h
		KEY_J:
			current_color = color_layout.j
		KEY_K:
			current_color = color_layout.k
		KEY_L:
			current_color = color_layout.l
		KEY_SEMICOLON:
			current_color = color_layout[";"]
		KEY_Z:
			current_color = color_layout.z
		KEY_X:
			current_color = color_layout.x
		KEY_C:
			current_color = color_layout.c
		KEY_V:
			current_color = color_layout.v
		KEY_B:
			current_color = color_layout.b
		KEY_N:
			current_color = color_layout.n
		KEY_M:
			current_color = color_layout.m
		KEY_COMMA:
			current_color = color_layout[","]
		KEY_PERIOD:
			current_color = color_layout["."]
		KEY_SLASH:
			current_color = color_layout["/"]
		_:
			current_color.a = 0.0
	
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
