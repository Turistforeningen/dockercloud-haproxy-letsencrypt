# dockercloud-haproxy-letsencrypt

Combining [dockercloud-haproxy](https://github.com/docker/dockercloud-haproxy)
and [certbot](https://certbot.eff.org/), these Docker Cloud services provide a
default load balancer with simplified SSL certificate handling.

This is more or less a clone of
[ixc/letsencrypt-dockercloud-haproxy](https://github.com/ixc/letsencrypt-dockercloud-haproxy).

## haproxy service

* See [dockercloud-haproxy](https://github.com/docker/dockercloud-haproxy)
* Add volume from `letsencrypt` service
* Install SSL certificates and reload automatically on changes

## letsencrypt service

* Issue certificates from `$DOMAINS` automatically
* Renew certificates automatically

### Environment

* `EMAIL`: Registration email used for issued certificates
* `DOMAINS`: Semicolon-separated list of certificates. Separate domains within
  each certificate with comma (e.g. `foo.com,www.foo.com;bar.com;www.bar.com`).
* `OPTIONS`: Additional arguments passed to `certbot` (e.g. `--staging`).
