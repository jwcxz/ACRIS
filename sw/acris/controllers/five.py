import backend.controller

class FiveRGBLeft(backend.controller.Controller):
    """ a five-rgb controller with the leftmost LED as 0 """

    def each(self, lights):
        self.set(lights);

    def all(self, color):
        _ = [ color for i in range(5) ];
        self.set(_);


class FiveRGBRight(backend.controller.Controller):
    """ a five-rgb controller with the rightmost LED as 0 """

    def each(self, lights):
        lights.reverse();
        self.set(lights);

    def all(self, color):
        _ = [ color for i in range(5) ];
        self.set(_);


#class FiveRGB(FiveLeft):
#    pass;
