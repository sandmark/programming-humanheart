import io

class Dictionary:
    DIC_RANDOM = 'dics/random.txt'

    def __init__(self):
        with open(self.DIC_RANDOM, 'r', encoding='utf-8') as f:
            self._random = [x.strip() for x in f.readlines()]

    @property
    def random(self):
        return self._random
