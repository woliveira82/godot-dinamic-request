extends Node

signal finished

var _queue: Array
var _response

@onready var _http_request


func post_request(request, handle_function: Callable):
	self.finished.connect(handle_function)
	self._response = null
	self._http_request = HTTPRequest.new()
	add_child(self._http_request)
	self._http_request.request_completed.connect(self._on_request_completed)
	self._http_request.request(request.url)
	await self._http_request.request_completed
	self.finished.emit(self._response)
	self.finished.disconnect(handle_function)
	self._http_request.queue_free()


func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		push_error("ERROR: Response status = %d" % response_code)
		return
	
	self._response = JSON.parse_string(body.get_string_from_utf8())
