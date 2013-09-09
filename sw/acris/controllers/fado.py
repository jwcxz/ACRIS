import backend.controller

class FADO(backend.controller.Controller):
    """ this is a modification for the IKEA FADO table lamp.  The middle three
    channels are used to control three LEDs that are all tied together.  So,
    not a good idea to set channels differently. """

    def all(self, color):
        self.set([ [0,0,0], color, color, color, [0,0,0] ]);
