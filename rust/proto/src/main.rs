use std::io;
use std::io::Write;

struct Responder {
    pub name: String,
}

impl Responder {
    fn new(name: &str) -> Responder {
        Responder {name: name.to_string()}
    }

    fn response(&self, input: String) -> String {
        format!("{}ってなに？", input)
    }
}

struct Unmo {
    pub name: String,
    pub responder: Responder,
}

impl Unmo {
    fn new(name: &str) -> Unmo {
        Unmo {
            name: name.to_string(),
            responder: Responder::new("What"),
        }
    }

    fn dialogue(&self, input: String) -> String {
        self.responder.response(input)
    }

    fn responder_name(&self) -> String {
        self.responder.name.clone()
    }
}

fn prompt(unmo: &Unmo) -> String {
    format!("{}:{}> ", unmo.name, unmo.responder_name())
}

fn main() {
    println!("Unmo System prototype : proto");
    let proto = Unmo::new("proto");
    loop {
        print!("> ");
        io::stdout().flush().ok().expect("failed to flush stdout");

        let mut input = String::new();
        io::stdin().read_line(&mut input).ok().expect("failed to read line");

        let input = input.trim();
        match input {
            "" => break,
            _  => {
                let response = proto.dialogue(input.to_string());
                println!("{}{}", prompt(&proto), response);
            }
        }
    }
}
