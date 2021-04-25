# nginx for tiny services

This nginx fronts as many services as I want on this computer.

## Usage

    # Start the dependent services (see the --link args in start).

    ./start

## certs

Certs are mounted from an on-disk directory. If you move tiny to another computer, you'll probably want to copy the data, too.

I generated a cert like this:

    ./certbot certonly --manual --preferred-challenges dns -d '*.pickardayune.com'

Renewing should only require this:

    ./certbot renew --dns-dnsimple
