extends CanvasLayer

onready var paper_container: ViewportContainer = $PaperContainer
onready var cursor: Sprite = $Cursor

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready():
	pass

func _process(_delta: float) -> void:
	cursor.position = paper_container.paper.counter

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_cursor"):
		cursor.visible = not cursor.visible
		get_tree().set_input_as_handled()

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################
