import backend.controller

class HKNBoard(backend.controller.Controller):
    """ these are the LED boards I created to demo ACRIS at the HKN expo """

    def each(self, lights):
        self.set(lights[0] + lights[1] + lights[2] + lights[3] + lights[4]);

    def all(self, color):
        self.set(color*5);
