from random import choice
from responder import RandomResponder, WhatResponder

class Unmo:
    def __init__(self, name):
        self._name = name
        self._responders = (
            RandomResponder('Random'),
            WhatResponder('What'),
        )

    def dialogue(self, line):
        self._responder = choice(self._responders)
        return self._responder.response(line)

    @property
    def responder_name(self):
        return self._responder.name

    @property
    def name(self):
        return self._name
