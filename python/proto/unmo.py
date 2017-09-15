from random import choice, randint
from responder import RandomResponder, WhatResponder
from dictionary import Dictionary

class Unmo:
    def __init__(self, name):
        self._name = name
        self._dic  = Dictionary()
        self._resp_random = RandomResponder('Random', self._dic)
        self._resp_what   = WhatResponder('What')

    def dialogue(self, line):
        r = randint(0, 100)
        if r < 10:
            self._responder = self._resp_what
        else:
            self._responder = self._resp_random

        return self._responder.response(line)

    @property
    def responder_name(self):
        return self._responder.name

    @property
    def name(self):
        return self._name
