# Nethack

We sometimes play a lot of nethack, and it's fun to have it on a server.

This runs as the telnet server on tiny. I also set up a 'nethack' user on tiny so that I can `ssh nethack@tiny` and play, because macOS doesn't include a telnet client anymore.

## Usage

    ./start

    # Set up my ssh key in ~nethack/.ssh

    # From another computer:
    ssh nethack@tiny.local
