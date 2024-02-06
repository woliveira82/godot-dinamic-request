extends Node

var _queue: Array
var _response


func post_request(request, handle_function: Callable):
	self._response = null
	var instance = HTTPRequest.new()
	add_child(instance)
	instance.request_completed.connect(self._on_request_completed)
	instance.request(request.url)
	await instance.request_completed
	handle_function.call(self._response)
	instance.queue_free()


func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		push_error("ERROR: Response status = %d" % response_code)
		return
	
	self._response = JSON.parse_string(body.get_string_from_utf8())
