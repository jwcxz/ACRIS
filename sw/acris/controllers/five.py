import backend.controller

class FiveRGBLeft(backend.controller.Controller):
    """ a five-rgb controller with the leftmost LED as 0 """

    def each(self, lights):
        self.set(lights[0] + lights[1] + lights[2] + lights[3] + lights[4]);

    def all(self, color):
        self.set(color*5);


class FiveRGBRight(backend.controller.Controller):
    """ a five-rgb controller with the rightmost LED as 0 """

    def each(self, lights):
        self.set(lights[4] + lights[3] + lights[2] + lights[1] + lights[0]);

    def all(self, color):
        self.set(color*5);


#class FiveRGB(FiveLeft):
#    pass;
