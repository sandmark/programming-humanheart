from unmo import Unmo

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
