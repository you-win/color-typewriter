extends Node2D

onready var paper_sprite: Sprite = $PaperSprite
onready var viewport: Viewport = $Viewport
onready var paper_display: CanvasLayer = $CanvasLayer/ViewportContainer/Viewport/PaperDisplay
onready var sounds: Node = $Sounds
onready var hammers: Node = $Hammers

var paper_size: Vector2
var paper_origin: Vector2

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	paper_size = paper_display.paper_container.paper.viewport.size
	paper_origin = paper_size / 2
	paper_origin.y *= 1.75
	paper_sprite.global_position = paper_origin

	paper_display.paper_container.paper.connect("cursor_incremented", self, "_on_cursor_incremented")
	
	for hammer in hammers.get_children():
		# TODO this is wrong but looks okay for some reason
		hammer.rotation = (hammer.position as Vector2).angle_to_point(Vector2.ZERO) - PI / 2

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_cursor_incremented(pos: Vector2) -> void:
	paper_sprite.position = paper_origin - pos
	
	_play_typing_sound()
	_activate_hammer(paper_origin)

###############################################################################
# Private functions                                                           #
###############################################################################

func _play_typing_sound() -> void:
	(sounds.get_child(round(rand_range(0, 2))) as AudioStreamPlayer).play(0)

func _activate_hammer(pos: Vector2) -> void:
	hammers.get_child(round(rand_range(0, hammers.get_child_count() - 1))).activate(pos)

###############################################################################
# Public functions                                                            #
###############################################################################
