extends HTTPRequest

var _response := {"ok": false, "data": "Error in request"}


func http_request(
	method: HTTPClient.Method,
	url: String,
	body: Dictionary = {},
 	headers: Dictionary = {},
):
	var custom_headers = self._dict_to_packed_string_array(headers)
	custom_headers.append("Content-Type: application/json")
	
	var request_data: String = ""
	if body:
		request_data = JSON.stringify(body)

	self.request(
		url,
		custom_headers,
		method,
		request_data,
	)
	await self.request_completed
	return self._response


func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		push_error("ERROR: Response status = %d" % response_code)
		return
	
	self._response.ok = true
	self._response.data = JSON.parse_string(body.get_string_from_utf8())


func _dict_to_packed_string_array(dictionary: Dictionary) -> PackedStringArray:
	var packed_sctring_array = PackedStringArray()
	for key in dictionary.keys():
		packed_sctring_array.append("%s: %s" % [key, dictionary[key]])
		
	return packed_sctring_array
