extends Node

signal finished

var _queue: Array
var _busy: bool = false
var _response

@onready var _http_request := $HTTPRequest


func post_request(request, handle_function: Callable):
	self.finished.connect(handle_function)
	self._queue.push_back(request)
	if not _busy:
		self._handle_next_request()


func _handle_next_request():
	if self._queue.size() > 0:
		var request = self._queue.pop_front()
		self._handle(request)
		await finished
		self._handle_next_request()


func _handle(request):
	self._busy = true
	self._response = null
	
	self._http_request.request_completed.connect(self._on_request_completed)
	self._http_request.request(request.url)
	await self._http_request.request_completed
	
	self._busy = false
	self.finished.emit(self._response)


func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		push_error("ERROR: Response status = %d" % response_code)
		return
	
	self._response = JSON.parse_string(body.get_string_from_utf8())
