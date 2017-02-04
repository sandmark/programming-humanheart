use responder::Responder;

pub struct Unmo {
    pub name: String,
    responder: Responder,
}

impl Unmo {
    pub fn new(name: &str) -> Unmo {
        Unmo {
            name: name.to_string(),
            responder: Responder::new("What"),
        }
    }

    pub fn dialogue(&self, input: String) -> String {
        self.responder.response(input)
    }

    pub fn responder_name(&self) -> String {
        self.responder.name.clone()
    }
}
