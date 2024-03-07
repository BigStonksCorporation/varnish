FROM varnish

RUN mkdir -p -m 1777 /var/lib/varnish/varnishd

COPY default.vcl /etc/varnish/
