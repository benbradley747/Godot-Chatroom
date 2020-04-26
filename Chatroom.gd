extends Control

onready var chatLog = get_node("VBoxContainer/RichTextLabel")
onready var inputLabel = get_node("VBoxContainer/HBoxContainer/Label")
onready var inputField = get_node("VBoxContainer/HBoxContainer/LineEdit")

var groups = [
	{'name': 'Team', 'color': '#34c5f1'},
	{'name': 'Global', 'color': '#f1c234'},
	{'name': 'Green', 'color': '#2fac10'},
]

var group_index = 0

#this will be retrieved from a server, for now it is hardcoded.
var user = "Ben"

func _ready():
	inputField.connect("text_entered", self, "text_entered")
	inputLabel.text = "[ " + groups[0]['name'] + " ]"
	inputLabel.set('custom_colors/font_color', Color(groups[group_index]['color']))
	inputField.placeholder_text = "Press TAB to change chat groups"

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			inputField.grab_focus()
		if event.pressed and event.scancode == KEY_ESCAPE:
			inputField.release_focus()
		if event.pressed and event.scancode == KEY_TAB:
			update_group()

func add_message(username, text, group):
	chatLog.bbcode_text += "\n"
	chatLog.bbcode_text += '[color=' + groups[group]['color'] + ']'
	chatLog.bbcode_text += "[ " + username + " ] " + text + '[/color]'

func text_entered(text):
	if text != '':
		#print(user + ": " + text)
		add_message(user, text, group_index)
		inputField.text = ''

func update_group():
	update_group_index()
	inputLabel.set('custom_colors/font_color', Color(groups[group_index]['color']))
	inputLabel.text = "[ " + groups[group_index]['name'] + " ]"

func update_group_index():
	group_index += 1
	if group_index > groups.size() - 1:
		group_index = 0
