tool
extends EditorScript


"""
Description:
	Runs through the current selected directory and its subdirectories
	searching for audio files, e.g. .ogg and .wav, creating AudioStreamRandomPitch
	resources from them.
"""

var filesys = get_editor_interface().get_resource_filesystem()
var selected_path = get_editor_interface().get_selected_path()
var selected_directory = filesys.get_filesystem_path(selected_path)

func _run():
	create_streams_from_directory(selected_directory)


func create_streams_from_directory(directory):
	for file in directory.get_file_count():
		create_stream_from_file(directory.get_file_path(file))
	for subdirectory in directory.get_subdir_count():
		var subdir = directory.get_subdir(subdirectory)
		create_streams_from_directory(subdir)


func create_stream_from_file(file):
	if not filesys.get_file_type(file) == "AudioStreamOGGVorbis":
		return
	var audio_stream_random_pitch = AudioStreamRandomPitch.new()
	audio_stream_random_pitch.audio_stream = load(file)
	var file_name = file.get_file().replace(file.get_extension(), "tres")
	var resource_path = selected_directory.get_path() + "audio_stream_random_pitches/" + file_name
	ResourceSaver.save(resource_path, audio_stream_random_pitch)
