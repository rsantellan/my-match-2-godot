#script: http_manager.gd
extends Node

func _ready():
	pass

# Creating a folder with a path!
func create_folder(path):
	var dir = Directory.new()
	var base = path.split("//")[0] + "//"
	dir.open(base)
	var folder_array = path.replacen(base, "").split("/")
	var cur_path = base
	for folder in folder_array:
		cur_path += folder + "/"
		if not dir.dir_exists(cur_path):
			dir.make_dir(cur_path)

func save_image_from_url(path, name, url):
	create_folder(path)
	var file = File.new()
	if not file.file_exists(path + name):
		#print ("not exists")
		#var httpRequest = HTTPRequest.new()
		#print ("new http request")
		#httpRequest.set_download_file(path+name)
		#print ("download_file is: " + path+name)
		#httpRequest.request(url)
		#print ("url is: " + url)
		var data = http_get(url)
		if data != null:
			print("saving: " + path + name)
			file.open(path + name, 2)
			file.store_buffer(data)
	file.close()

func save_image_from_url_full(path, name, url, domain, port):
	create_folder(path)
	var file = File.new()
	if not file.file_exists(path + name):
		var data = do_http_get(url, domain, port)
		if data != null:
			file.open(path + name, 2)
			file.store_buffer(data)
			file.close()	
	pass

func http_get(url):
	var topAddress = "http://"+url.split('/')[2]
	print(topAddress)
	return do_http_get(url, topAddress, 80)
	pass
	
func do_http_get(url, domain, port):
	var err=0
	var http = HTTPClient.new() # Create the Client
	
	var subAddress = url.replace(domain, "")
	print(domain)
	print(subAddress)
	var err = http.connect(domain, 80) # Connect to host/port
	assert(err==OK) # Make sure connection was OK
	while( http.get_status()==HTTPClient.STATUS_CONNECTING or http.get_status()==HTTPClient.STATUS_RESOLVING):
		#Wait until resolved and connected
		http.poll()
		OS.delay_msec(500)
 	print(http.get_status())
	assert( http.get_status() == HTTPClient.STATUS_CONNECTED ) # Could not connect
 
	# Some headers
	var headers=[
		"User-Agent: Pirulo/1.0 (Godot)",
		"Accept: */*"
	]
	err = http.request(HTTPClient.METHOD_GET, subAddress, headers) # Request a page from the site (this one was chunked..)

	assert( err == OK ) # Make sure all is OK

	while (http.get_status() == HTTPClient.STATUS_REQUESTING):
		# Keep polling until the request is going on
		http.poll()
		OS.delay_msec(500)
 
	assert( http.get_status() == HTTPClient.STATUS_BODY or http.get_status() == HTTPClient.STATUS_CONNECTED ) # Make sure request finished well.
	if (http.has_response()):
		#If there is a response..
		var headers = http.get_response_headers_as_dictionary() # Get response headers

		var rb = RawArray() #array that will hold the data

		print("bytes expexted:", http.get_response_body_length())

		while(http.get_status()==HTTPClient.STATUS_BODY):
			#While there is body left to be read
			print (http.get_status())
			http.poll()
			OS.delay_usec(1000) # added it here
			var chunk = http.read_response_body_chunk() # Get a chunk
			if (chunk.size()==0):
				#got nothing, wait for buffers to fill a bit
				OS.delay_usec(1000)
			else:
				rb = rb + chunk # append to read bufer
			print("bytes got: ",rb.size())
			var content = headers["Content-Type"]
			if content.findn("image/") == -1:
				var text = rb.get_string_from_ascii()
				http.close()
				return text
			else:
				http.close()
				return rb
	else:
		http.close()
		return null