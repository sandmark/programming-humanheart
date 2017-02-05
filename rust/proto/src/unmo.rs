extern crate rand;
use self::rand::Rng;

use responder::*;

enum ResponderType {
    What,
    Random,
}

pub struct Unmo {
    pub name: String,
    resp_what: WhatResponder,
    resp_random: RandomResponder,
    current: ResponderType,
}

impl Unmo {
    pub fn new(name: &str) -> Unmo {
        Unmo {
            name: name.to_string(),
            resp_what: WhatResponder::new("What"),
            resp_random: RandomResponder::new("Random"),
            current: ResponderType::Random,
        }
    }

    fn responder(&self) -> &Responder {
        match self.current {
            ResponderType::Random => &self.resp_random,
            ResponderType::What   => &self.resp_what,
        }
    }

    pub fn dialogue(&mut self, input: String) -> String {
        let n = rand::thread_rng().gen_range(0,2);
        match n {
            0 => self.current = ResponderType::Random,
            1 => self.current = ResponderType::What,
            _ => ()
        }
        self.responder().response(input)
    }

    pub fn responder_name(&self) -> String {
        self.responder().name()
    }
}
