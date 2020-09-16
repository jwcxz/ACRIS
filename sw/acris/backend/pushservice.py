import urllib.request
import json

class HomebridgePushService:
    def __init__(self, host, port):
        self.host = host;
        self.port = port;

    def push_state(self, plugin_name, new_state):
        try:
            post_body = json.dumps({
                "characteristic": "On",
                "value": new_state
                }).encode();

            url = "http://%s:%d/acris-%s" % (self.host, self.port, plugin_name);

            response = urllib.request.urlopen(url, post_body);
        except Exception as e:
            sys.stderr.write("Warning: Failed to push notification\n");
            sys.stderr.write("    %r\n" % e);
