vcl 4.1;

backend default {
	.host = "192.168.131.198";
	.port = "80";
	.probe = { 
		.url = "/";
		.timeout = 1s;
		.interval = 5s;
		.window = 5;
		.threshold = 3; 
	}
}

# Respond to incoming requests.
sub vcl_recv {
  # Allow the backend to serve up stale content if it is responding slowly.
  set req.grace = 12h;
}

# Code determining what to do when serving items from the Apache servers.
sub vcl_fetch {
  # Allow items to be stale if needed.
  set beresp.grace = 12h;
}