vcl 4.1;
import std;

backend default {
	.host = "192.168.128.123";
	.port = "80";
	.probe = { 
		.url = "/";
		.timeout = 1s;
		.interval = 30s;
		.window = 5;
		.threshold = 3; 
	}
}

sub vcl_backend_response {
	if (bereq.url ~ "/" || bereq.url ~ "/index.php") {
		set beresp.ttl = 5m;
		set beresp.http.Cache-control = "public, max-age=300";
	}

	if (bereq.url ~ "/postimage.php" || bereq.url ~ "/postimage.php") {
		set beresp.ttl = 24h;
		set beresp.http.Cache-control = "public, max-age=86400";
	}

	# set beresp.grace = 12h;
	// no keep - the grace should be enough for 304 candidates
}

sub vcl_recv {
	# if (std.healthy(req.backend_hint)) {
	# 	// change the behavior for healthy backends: Cap grace to 10s
	# 	set req.grace = 10s;
	# }
}