extends Node

@export var _generic_scene_tscn := preload("res://generic_request.tscn")


func request(method: String, url: String, body: Dictionary = {}, headers: Dictionary = {}):
	var http_method: HTTPClient.Method
	match method.to_upper():
		"GET":
			http_method = HTTPClient.METHOD_GET
		"POST":
			http_method = HTTPClient.METHOD_POST
		"PUT":
			http_method = HTTPClient.METHOD_PUT
		"DELETE":
			http_method = HTTPClient.METHOD_DELETE
		_:
			http_method = HTTPClient.METHOD_GET
	
	return await self._request(http_method, url, body, headers)


func get_(url: String, headers: Dictionary = {}):
	return await self._request(HTTPClient.METHOD_GET, url, {}, headers)


func post(url: String, body: Dictionary = {}, headers: Dictionary = {}):
	return await self._request(HTTPClient.METHOD_POST, url, body, headers)


func put(url: String, body: Dictionary = {}, headers: Dictionary = {}):
	return await self._request(HTTPClient.METHOD_PUT, url, body, headers)


func delete(url: String, body: Dictionary = {}, headers: Dictionary = {}):
	return await self._request(HTTPClient.METHOD_DELETE, url, body, headers)


func _request(method: HTTPClient.Method, url: String, body: Dictionary = {}, headers: Dictionary = {}):
	var instance = self._generic_scene_tscn.instantiate()
	add_child(instance)
	var response = await instance.http_request(method, url, body, headers)
	instance.queue_free()
	return response
