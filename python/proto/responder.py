from random import choice

class Responder:
    def __init__(self, name, dic=None):
        self._name = name
        self._dic  = dic

    def response(self, line):
        return ''

    @property
    def name(self):
        return self._name

class WhatResponder(Responder):
    def __init__(self, name):
        super().__init__(name)

    def response(self, line):
        return '{}ってなに？'.format(line)

class RandomResponder(Responder):
    def __init__(self, name, dic):
        super().__init__(name, dic)

    def response(self, line):
        return choice(self._dic.random)
