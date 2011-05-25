import backend.controller

class HKNBoard(backend.controller.Controller):
    """ these are the LED boards I created to demo ACRIS at the HKN expo """

    def each(self, lights):
        self.set(lights);

    def all(self, color):
        _ = [ color for i in range(5) ];
        self.set(_);
