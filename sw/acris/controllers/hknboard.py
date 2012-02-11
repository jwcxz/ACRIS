import backend.controller

class WallSconce(backend.controller.Controller):
    """ these are the LED boards I created to demo ACRIS at the HKN expo """

    def each(self, top, center, bottom):
        self.set(top + [0,0,0] + center + [0,0,0] + bottom);

    def all(self, color):
        self.set(color + [0,0,0] + color + [0,0,0] + color);

    def center(self, center):
        self.set([0,0,0, 0,0,0] + center + [0,0,0, 0,0,0]);

    def twotone(self, center, sides):
        self.set(sides + [0,0,0] + center + [0,0,0] + sides);
