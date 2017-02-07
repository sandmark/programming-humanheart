use std::io;
use std::io::Write;

mod responder;
mod unmo;
mod dictionary;
use unmo::Unmo;

fn prompt(unmo: &Unmo) -> String {
    format!("{}:{}> ", unmo.name, unmo.responder_name())
}

fn main() {
    println!("Unmo System prototype : proto");
    let mut proto = Unmo::new("proto");
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
