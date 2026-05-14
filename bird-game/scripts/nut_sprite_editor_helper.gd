@tool
extends Node

func _process(_delta):
    if not Engine.is_editor_hint():
        return

    var nut = get_parent()
    if not nut:
        return

    if not nut.nut_data:
        return

    var sprite = nut.get_node("Walnut")
    sprite.texture = nut.nut_data.texture
