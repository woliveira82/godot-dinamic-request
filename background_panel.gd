extends Panel


func _on_button_pressed():
	var request = {
		"method": "GET",
		"url": "https://catfact.ninja/fact?max_length=100",
	}
	Service.post_request(request)
