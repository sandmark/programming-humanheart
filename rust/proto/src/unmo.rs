use responder::RandomResponder;

pub struct Unmo {
    pub name: String,
    responder: RandomResponder,
}

impl Unmo {
    pub fn new(name: &str) -> Unmo {
        Unmo {
            name: name.to_string(),
            responder: RandomResponder::new("Random"),
        }
    }

    pub fn dialogue(&self, input: String) -> String {
        self.responder.response(input)
    }

    pub fn responder_name(&self) -> String {
        self.responder.name.clone()
    }
}
