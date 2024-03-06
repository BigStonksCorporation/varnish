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
import std;

sub vcl_backend_response {
     set beresp.grace = 12h;
     // no keep - the grace should be enough for 304 candidates
}

sub vcl_recv {
     if (std.healthy(req.backend_hint)) {
          // change the behavior for healthy backends: Cap grace to 10s
          set req.grace = 10s;
     }
}