# ACRIS Homebridge Configuration Example

ACRIS can be used with [Homebridge](https://github.com/homebridge/homebridge),
[homebridge-http-rgb-push](https://github.com/QuickSander/homebridge-http-rgb-push),
and
[homebridge-http-notification-server](https://github.com/Supereg/homebridge-http-notification-server)
to present plugins as HomeKit lights (RGB, brightness-only, or switch-only).
Starting a new plugin will automatically shut off active mutually-incompatible
plugins (i.e. those that address the same lights).  Usage of push notifications
ensures lights are updated quickly in the Home app.


## Installation

1.  Install Homebridge, homebridge-http-rgb-push, and
    homebridge-http-notification server:

        sudo npm install -g --unsafe-perm homebridge
        sudo npm install -g homebridge-http-rgb-push
        sudo npm install -g homebridge-http-notification-server

2.  In `~/.homebridge/config.json`, include accessories like those shown in the
    example `config.snippet.json`.

3.  Add a `~/.homebridge/notification-server.json` similar to the example in
    this directory.


## Operation

1.  Start ACRIS with push notifications:

        ./sw/acris/acris.py --homebridge-push-host localhost --homebridge-push-port 55556

2.  Start Homebridge:

        homebridge

3.  Add the Homebridge bridge to your Home if not yet done.
