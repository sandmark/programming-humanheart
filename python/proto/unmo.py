from responder import RandomResponder

class Unmo:
    def __init__(self, name):
        self._name = name
        self._responder = RandomResponder('Random')

    def dialogue(self, line):
        return self._responder.response(line)

    @property
    def responder_name(self):
        return self._responder.name

    @property
    def name(self):
        return self._name
