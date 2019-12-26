tool
extends EditorScript

const PATH = "res://interface/themes/"

func _run():
	var interface = get_editor_interface()
	var filesys = interface.get_resource_filesystem()
	var dir = filesys.get_filesystem_path(PATH)
	
	for f in dir.get_file_count():
		var path = dir.get_file_path(f)
		if not filesys.get_file_type(path) == "Theme":
			continue
		else:
			create_directory(path.replace("_theme.tres", "/"))
			style_box(load(path), path.replace("_theme.tres", "/"))
	
	filesys.scan()
	
func style_box(theme, path):
	# Normal
	var box = StyleBoxFlat.new()
	
	box.set_border_width_all(4)
	box.set_corner_radius_all(8)
	box.bg_color = theme.main_color
	box.border_color = theme.main_color.darkened(0.3)
	
	ResourceSaver.save(path + "normal.tres", box)
	
	
	# Pressed
	box = StyleBoxFlat.new()
	
	box.set_border_width_all(4)
	box.set_corner_radius_all(8)
	box.bg_color = theme.main_color.darkened(0.2)
	box.border_color = theme.main_color.darkened(0.4)
	
	ResourceSaver.save(path + "pressed.tres", box)
	
	# Hover
	box = StyleBoxFlat.new()
	
	box.set_border_width_all(4)
	box.set_corner_radius_all(8)
	box.bg_color = theme.main_color.lightened(0.2)
	box.border_color = theme.main_color.darkened(0.1)
	
	ResourceSaver.save(path + "hover.tres", box)
	
	# Disabled
	box = StyleBoxFlat.new()
	
	box.set_border_width_all(4)
	box.set_corner_radius_all(8)
	var gray = theme.main_color.gray()
	var gray_color = Color(gray, gray, gray)
	box.bg_color = gray_color
	box.border_color = gray_color.darkened(0.3)
	
	ResourceSaver.save(path + "disabled.tres", box)
	
	# Focus
	box = StyleBoxFlat.new()
	
	box.set_border_width_all(4)
	box.set_corner_radius_all(8)
	box.bg_color = theme.main_color
	box.border_color = Color(1, 1, 1, 1)
	
	ResourceSaver.save(path + "focus.tres", box)
	
	# Grabber
	var grabber = box.duplicate()
	ResourceSaver.save(path + "grabber.tres", grabber)
	# Highlight
	grabber.bg_color = box.bg_color.lightened(0.2)
	ResourceSaver.save(path + "grabber_highlight.tres", grabber)
	# Pressed
	grabber.bg_color = box.bg_color.darkened(0.2)
	ResourceSaver.save(path + "grabber_pressed.tres", grabber)
	
	# Scroll
	box = StyleBoxFlat.new()
	box.set_border_width_all(4)
	box.set_corner_radius_all(8)
	box.bg_color = theme.main_color
	box.border_color = theme.main_color.lightened(0.2)
	ResourceSaver.save(path + "scroll.tres", box)
	# Focus
	box = StyleBoxFlat.new()
	box.set_border_width_all(4)
	box.set_corner_radius_all(8)
	box.bg_color = theme.main_color.lightened(0.2)
	box.border_color = theme.main_color.lightened(0.4)
	ResourceSaver.save(path + "scroll_focus.tres", box)
	
	# Empty
	box = StyleBoxEmpty.new()
	ResourceSaver.save(path + "empty.tres", box)
	
	# Panel
	box = StyleBoxFlat.new()
	box.set_corner_radius_all(8)
	box.bg_color = theme.main_color
	ResourceSaver.save(path + "panel.tres", box)
	
	# Tab foreground
	box = StyleBoxFlat.new()
	box.set_border_width_all(4)
	box.set_corner_radius_all(8)
	box.bg_color = theme.main_color
	box.border_color = Color(1, 1, 1, 1)
	ResourceSaver.save(path + "tab_fg.tres", box)
	# Tab background
	box = StyleBoxFlat.new()
	box.set_border_width_all(4)
	box.set_corner_radius_all(8)
	box.bg_color = theme.main_color.darkened(0.3)
	box.border_color = theme.main_color.darkened(0.1)
	ResourceSaver.save(path + "tab_bg.tres", box)
	
func create_directory(path):
	var dir = Directory.new()
	if dir.dir_exists(path):
		return
	dir.make_dir(path)