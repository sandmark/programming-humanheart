extern crate rand;

use self::rand::Rng;

pub trait Responder {
    fn response(&self, input: String) -> String;
    fn name(&self) -> String;
}

pub struct WhatResponder {
    name: String,
}

pub struct RandomResponder {
    name: String,
    responses: Vec<String>,
}

impl Responder for WhatResponder {
    fn name(&self) -> String {
        self.name.clone()
    }

    fn response(&self, input: String) -> String {
        format!("{}ってなに？", input)
    }
}

impl Responder for RandomResponder {
    fn name(&self) -> String {
        self.name.clone()
    }

    fn response(&self, input: String) -> String {
        let n = rand::thread_rng().gen_range(0, self.responses.len());
        self.responses[n].clone()
    }
}

impl WhatResponder {
    pub fn new(name: &str) -> WhatResponder {
        WhatResponder {name: name.to_string()}
    }
}

impl RandomResponder {
    pub fn new(name: &str) -> RandomResponder {
        let v =
            vec!["今日はさむいね","チョコたべたい","きのう10円ひろった"];
        let v = v.iter().map(|&x| x.to_string()).collect::<Vec<String>>();
        RandomResponder {
            name: name.to_string(),
            responses: v,
        }
    }
}
