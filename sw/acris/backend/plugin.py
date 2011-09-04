import threading

class Plugin(threading.Thread):
    enabled = False;

    def __init__(self, network, args):
        threading.Thread.__init__(self);
        # what to do on initialization of the plugin
        self.network = network;
        self.args = args;
        self.enabled = False;

    def run(self):
        # called to start the thread
        self.enabled = True

    def stop(self):
        # called when the thread is stopped
        self.enabled = False
