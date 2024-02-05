extends Node

signal finished

var _queue: Array
var _busy: bool = false


func post_request(request):
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
	# do stuff
	
	var instance = HTTPRequest.new()
	instance.request(request.url)
	await instance.request_completed
	
	
	
	# do stuff
	self._busy = false
	self.finished.emit()
