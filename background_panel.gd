extends Panel

@onready var cat_rich_text := $CatVBoxContainer/CatRichTextLabel
@onready var dog_rich_text := $DogVBoxContainer/DogRichTextLabel


func _on_button_pressed():
	var request = {
		"method": "GET",
		"url": "https://catfact.ninja/fact?max_length=100",
	}
	Service.post_request(request, self._handle)


func _handle(response):
	self.cat_rich_text = response.fact


func _on_dog_button_pressed():
	var request = {
		"method": "GET",
		"url": "https://dog-api.kinduff.com/api/facts?number=1",
	}
	Service.post_request(request, self._handle_dog_request)


func _handle_dog_request(response):
	self.dog_rich_text.text = response.facts[0]


func _on_cat_button_pressed():
	var request = {
		"method": "GET",
		"url": "https://catfact.ninja/fact?max_length=100",
	}
	Service.post_request(request, self._handle_cat_request)


func _handle_cat_request(response):
	self.cat_rich_text.text = response.fact
