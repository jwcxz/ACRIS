from http.server import HTTPServer, BaseHTTPRequestHandler
import socket

from urllib.parse import urlparse, parse_qs
import os.path
import json


# API

# /acris/start/PLUGIN?cfg1=val&cfg2=val
# /acris/start/PLUGIN/force?cfg1=val&cfg2=val

# /acris/stop/PLUGIN

# /acris/status/PLUGIN
# /acris/status/PLUGIN/state
# /acris/status/PLUGIN/params
# /acris/status/PLUGIN/params?param=PARAM
# /acris/status/PLUGIN/params?param=PARAM&format=hex

# /acris/stopall

# /acris/list
# /acris/list/all_plugins
# /acris/list/active_plugins
# /acris/list/active_addresses

# /acris/refresh

# /acris/die


class AcrisRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        parsed_url = urlparse(self.path);

        query = parse_qs(parsed_url.query);
        path = parsed_url.path.split('/')[1:];

        print(parsed_url);
        print(path, query);

        if len(path) < 2:
            self.send_syntax_err();

        if path[0] != "acris":
            self.send_syntax_err();

        command = path[1];
        args = path[2:];

        # this protocol does not use multiple values per field
        params = {};
        for key in query:
            try:
                params[key] = json.loads(query[key][0]);
            except json.decoder.JSONDecodeError:
                params[key] = query[key][0];

        print("Got request: %s" % self.path);
        print("    Command: %s" % command);
        print("    Args:    %r" % args);
        print("    Params:  %r" % params);

        result = self.acris.interpreter.execute(command, args, params);

        if result == True:
            self.send_success();
            self.end_headers();
            self.wfile.write("".encode());
        elif result == False:
            # TODO: fix this
            self.send_syntax_err();
        elif result == None:
            # TODO: fix this
            self.send_syntax_err();
        else:
            try:
                output_str = result.encode();
            except AttributeError as e:
                output_str = json.dumps(result).encode();

            self.send_success();
            self.end_headers();
            self.wfile.write(output_str);


    def send_syntax_err(self):
        self.send_response(400);


    def send_success(self):
        self.send_response(200);


def get_httpd(acris, host, port):
    # https://stackoverflow.com/questions/21631799/how-can-i-pass-parameters-to-a-requesthandler
    def make_BoundAcrisRequestHandler(acris):
        class BoundAcrisRequestHandler(AcrisRequestHandler):
            def __init__(self, *args, **kwargs):
                self.acris = acris;

                super(BoundAcrisRequestHandler, self).__init__(*args,
                        **kwargs);

        return BoundAcrisRequestHandler;

    httpd = HTTPServer((host, port), make_BoundAcrisRequestHandler(acris));

    return httpd;
