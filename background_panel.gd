extends Panel

@onready var method_line_edit := $VBoxContainer/MethodLineEdit
@onready var url_line_edit := $VBoxContainer/UrlLineEdit
@onready var body_line_edit := $VBoxContainer/BodyLineEdit
@onready var headers_linee_dit := $VBoxContainer/HeadersLineEdit
@onready var response_rich_text := $VBoxContainer/RichTextLabel


func _on_button_pressed():
	var response = await Service.request(
		method_line_edit.text,
		url_line_edit.text
		)
	
	response_rich_text.text = response.data.status
