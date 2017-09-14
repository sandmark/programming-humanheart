from random import choice

class Responder:
    def __init__(self, name):
        self._name = name

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
    def __init__(self, name):
        super().__init__(name)
        self._responses = ['今日はさむいね', 'チョコたべたい', 'きのう10円ひろった']

    def response(self, line):
        return choice(self._responses)
