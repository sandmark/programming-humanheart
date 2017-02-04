extern crate rand;

use self::rand::Rng;

pub struct WhatResponder {
    pub name: String,
}

impl WhatResponder {
    pub fn new(name: &str) -> WhatResponder {
        WhatResponder {name: name.to_string()}
    }

    pub fn response(&self, input: String) -> String {
        format!("{}ってなに？", input)
    }
}

pub struct RandomResponder {
    pub name: String,
    responses: Vec<String>,
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

    pub fn response(&self, input: String) -> String {
        let n = rand::thread_rng().gen_range(0, self.responses.len());
        self.responses[n].clone()
    }
}
