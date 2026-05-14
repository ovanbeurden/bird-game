extends Camera2D

func _process(_delta):
    # Keep the camera to the bottom of the screen
    var viewport_size = get_viewport_rect().size
    position.y = -viewport_size.y / 2
