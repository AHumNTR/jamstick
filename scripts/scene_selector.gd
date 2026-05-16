extends Control


# Called when the node enters the scene tree for the first time.
func changeScene(newSceneFileLocation:String):
	get_tree().change_scene_to_file(newSceneFileLocation)
