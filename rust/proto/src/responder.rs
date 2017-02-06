extern crate rand;

use self::rand::Rng;
use std::fs;
use std::fs::File;
use std::io;
use std::io::prelude::*;
use std::path::Path;

fn select_random(v: &Vec<String>) -> String {
    let len = v.len();
    if len == 0 {
        String::new()
    } else {
        let n = rand::thread_rng().gen_range(0, len);
        v[n].clone()
    }
}

pub trait Responder {
    fn response(&self, input: String) -> String;
    fn name(&self) -> String;
}

pub struct WhatResponder {
    name: String,
}

pub struct RandomResponder {
    name: String,
    phrases: Vec<String>,
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
        select_random(&self.phrases)
    }
}

impl WhatResponder {
    pub fn new(name: &str) -> WhatResponder {
        WhatResponder {name: name.to_string()}
    }
}

impl RandomResponder {
    pub fn new(name: &str) -> RandomResponder {
        RandomResponder {
            name: name.to_string(),
            phrases: RandomResponder::load_dic(),
        }
    }

    // 空辞書を作成 or ロード
    fn load_dic() -> Vec<String> {
        let dict = &Path::new("dics/random.txt");

        // 空の辞書ファイルを作成。存在する場合は無視
        RandomResponder::check_dict("dics", dict);

        // ファイルの内容を読み込む
        let s = match RandomResponder::read_file(dict) {
            Err(e) => panic!("! {:?}", e),
            Ok(s)  => s,
        };

        // '(\r)\n' による分割
        let lines = s.lines();
        let mut res: Vec<String> = Vec::new();
        for line in lines {
            match line {
                "" => continue,
                _  => res.push(line.to_string()),
            }
        }
        res
    }

    // 辞書・ディレクトリのチェック
    // 無ければ作成し、あれば何もしない
    fn check_dict(dir: &str, path: &Path) {
        if !&Path::new(dir).exists() {
            // ディレクトリの作成
            fs::create_dir(dir).unwrap_or_else(|why| {
                panic!("failed to create directory: {:?}", why);
            });
        }

        if !path.exists() {
            File::create(path).unwrap_or_else(|why| {
                panic!("faild to create {}: {:?}", path.display(), why);
            });
        }
    }

    // ファイル読み込み
    fn read_file(path: &Path) -> io::Result<String> {
        let mut f = try!(File::open(path));
        let mut s = String::new();
        match f.read_to_string(&mut s) {
            Err(e) => Err(e),
            Ok(_)  => Ok(s),
        }
    }
}
