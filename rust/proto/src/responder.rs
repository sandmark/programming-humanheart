pub struct Responder {
    pub name: String,
}

impl Responder {
    pub fn new(name: &str) -> Responder {
        Responder {name: name.to_string()}
    }

    pub fn response(&self, input: String) -> String {
        format!("{}ってなに？", input)
    }
}
