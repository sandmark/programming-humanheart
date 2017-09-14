class Responder:
    def __init__(self, name):
        self._name = name

    def response(self, line):
        return '{}ってなに？'.format(line)

    @property
    def name(self):
        return self._name

class Unmo:
    def __init__(self, name):
        self._name = name
        self._responder = Responder('What')

    def dialogue(self, line):
        return self._responder.response(line)

    @property
    def responder_name(self):
        return self._responder.name

    @property
    def name(self):
        return self._name

def prompt(unmo):
    return '{}:{}> '.format(unmo.name, unmo.responder_name)

def main():
    print('Unmo System prototype : proto')
    proto = Unmo('proto')
    while True:
        line = input('> ').strip()
        if not line:
            break

        response = proto.dialogue(line)
        print('{}{}'.format(prompt(proto), response))


if __name__ == '__main__':
    main()
