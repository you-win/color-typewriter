extends Node2D

onready var paper_sprite: Sprite = $PaperSprite
onready var viewport: Viewport = $Viewport
onready var paper_display: CanvasLayer = $CanvasLayer/ViewportContainer/Viewport/PaperDisplay
onready var typing_sounds: Node = $TypingSounds
onready var ding_sounds: Node = $DingSounds
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
	paper_display.paper_container.paper.connect("carriage_return", self, "_on_carriage_return")
	
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

func _on_carriage_return(pos: Vector2, is_manual: bool) -> void:
	paper_sprite.position = paper_origin - pos
	
	if not is_manual:
		_play_ding_sound()

###############################################################################
# Private functions                                                           #
###############################################################################

func _play_typing_sound() -> void:
	(typing_sounds.get_child(round(rand_range(0, 2))) as AudioStreamPlayer).play(0)

func _play_ding_sound() -> void:
	(ding_sounds.get_child(round(rand_range(0, 1))) as AudioStreamPlayer).play(0)

func _activate_hammer(pos: Vector2) -> void:
	hammers.get_child(round(rand_range(0, hammers.get_child_count() - 1))).activate(pos)

###############################################################################
# Public functions                                                            #
###############################################################################
