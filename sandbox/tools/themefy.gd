tool
extends EditorScript

const PATH = "res://interface/themes/"

func _run():
	var interface = get_editor_interface()
	var filesys = interface.get_resource_filesystem()
	var dir = filesys.get_filesystem_path(PATH)
	var count = 0
	for f in dir.get_file_count():
		var path = dir.get_file_path(f)
		if not filesys.get_file_type(path) == "Theme":
			continue
		var theme = load(path)
		theme.set_default_font(load("res://interface/fonts/kenvector_future_14.tres"))
		set_stylebox(theme)
		set_color(theme)
		var subdir_index = dir.get_parent().find_dir_index(dir.get_file(f).replace("_theme.tres", ""))
		var subdir = dir.get_parent().get_subdir(subdir_index)
		set_icons(theme, subdir)
		ResourceSaver.save(theme.get_path(), theme)
		count +=1
	
	filesys.scan()
	
func set_stylebox(theme):
	for t in theme.get_type_list(""):
		for s in theme.get_stylebox_list(t):
			if t == "Tree":
				continue
			var path = theme.get_path().replace("_theme.tres", "/")
			if t == "Label" or t == "check":
				path += "empty.tres"
				var box = load(path)
			if s == "grabber_area" or s == "fg":
				path += "scroll_focus.tres"
			elif s == "slider" or s == "bg":
				path += "scroll.tres"
			else:
				var file = File.new()
				path += s + ".tres"
				# check if the path exists, first
				if not file.file_exists(path):
					continue
			var box = load(path)
			theme.set_stylebox(s, t, box)
			
func set_color(theme):
	for t in theme.get_type_list(""):
		for c in theme.get_color_list(t):
			var color = theme.font_color
			if "disabled" in c:
				color = Color(color.gray(), color.gray(), color.gray())
			elif "hover" in c:
				color = color.lightened(0.2)
			elif "pressed" in c:
				color = color.darkened(0.2)
			elif "shadow" in c:
				color = theme.main_color.inverted()
			theme.set_color(c, t, color)
			
func set_icons(theme, dir):
	for t in theme.get_type_list(""):
		for i in theme.get_icon_list(t):
			var icon = null
			if i == "close":
				icon = load(find_file(dir, "cross"))
			elif i == "checked":
				icon = load(find_file(dir, "boxCheckmark"))
			elif i == "radio_checked":
				icon = load(find_file(dir, "boxTick"))
			elif i == "radio_unchecked":
				icon = load("res://interface/grey/grey_circle.png")
			elif i == "unchecked":
				icon = load("res://interface/grey/grey_box.png")
			elif i == "on":
				icon = load(find_file(dir, "boxCheckmark"))
			elif i == "off":
				icon = load(find_file(dir, "boxCross"))
			theme.set_icon(i, t, icon)

func find_file(dir, contain):
	for f_index in dir.get_file_count():
		if contain in dir.get_file(f_index):
			return dir.get_file_path(f_index)

