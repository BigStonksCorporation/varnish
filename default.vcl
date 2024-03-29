vcl 4.1;

import directors;

backend server1 {
	.host = "192.168.128.81";
	.port = "80";
}

backend server2 {
	.host = "192.168.130.224";
	.port = "80";
}

backend server3 {
	.host = "192.168.128.123";
	.port = "80";
}

sub vcl_init {
    new balancer = directors.round_robin();
    balancer.add_backend(server1);
    balancer.add_backend(server2);
		balancer.add_backend(server3);
}

sub vcl_recv {
    set req.backend_hint = balancer.backend();
}

sub vcl_backend_response {
	if (bereq.url ~ "/" || bereq.url ~ "/index.php") {
		set beresp.ttl = 1h;
		set beresp.http.Cache-control = "public, max-age=3600";
	}

	if (bereq.url ~ "/postimage.php" || bereq.url ~ "/postimage.php") {
		set beresp.ttl = 24h;
		set beresp.http.Cache-control = "public, max-age=86400";
	}
}