import io
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
        with io.open('dics/random.txt', 'r', encoding='utf-8') as f:
            self._phrases = [line.strip() for line in f.readlines()]

    def response(self, line):
        return choice(self._phrases)
