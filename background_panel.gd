extends Panel

@onready var rich_text := $VBoxContainer/RichTextLabel


func _on_button_pressed():
	var request = {
		"method": "GET",
		"url": "https://catfact.ninja/fact?max_length=100",
	}
	Service.post_request(request, self._handle)


func _handle(response):
	self.rich_text.text = response.fact
