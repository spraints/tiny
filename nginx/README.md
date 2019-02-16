# nginx for tiny services

This nginx fronts as many services as I want on this computer.

## certs

I generated a cert like this:

    ./certbot certonly --manual --preferred-challenges dns -d '*.pickardayune.com'

Renewing should only require this:

    ./certbot renew
