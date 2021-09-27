extends Sprite

onready var tween: Tween = $Tween

var initial_position

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	initial_position = position
	
	tween.connect("tween_all_completed", self, "_on_complete")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_complete() -> void:
	position = initial_position

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func activate(pos: Vector2) -> void:
	tween.interpolate_property(self, "position", initial_position, Vector2(0.0, pos.y), 0.1)
	tween.start()
