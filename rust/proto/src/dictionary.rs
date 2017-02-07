use std::path::Path;
use std::fs;
use std::fs::File;
use std::io;
use std::io::prelude::*;

pub struct Dictionary {
    random: Vec<String>,
    pattern: Vec<(String, Vec<String>)>,
}

impl Dictionary {
    fn new() -> Dictionary {
        let dic_random  = Path::new("dics/random.txt");
        let dic_pattern = Path::new("dics/pattern.txt");
        Dictionary::check_existance_dir(&dic_random.parent().unwrap());
        Dictionary::check_existance(&dic_random);
        Dictionary::check_existance(&dic_pattern);

        let random: Vec<String> =
            Dictionary::load_random(dic_random);
        let pattern: Vec<(String, Vec<String>)> =
            Dictionary::load_pattern(dic_pattern);

        Dictionary {
            random: random,
            pattern: pattern,
        }
    }

    fn load_pattern(path: &Path) -> Vec<(String, Vec<String>)> {
        let mut f = File::open(path).unwrap_or_else(|e| {
            panic!("failed to open: {:?}", e);
        });

        let mut s = String::new();
        f.read_to_string(&mut s).unwrap_or_else(|e| {
            panic!("failed to read: {:?}", e);
        });

        let mut res: Vec<(String, Vec<String>)> = Vec::new();
        for line in s.lines() {
            let patterns: Vec<String> =
                line.split('\t').map(|s| s.to_string()).collect();
            if patterns.len() < 2 {
                continue;
            } else {
                res.push((patterns[0].clone(), patterns[1..].to_vec()));
            }
        }
        res
    }

    fn load_random(path: &Path) -> Vec<String> {
        let mut f = File::open(path).unwrap_or_else(|e| {
            panic!("failed to open: {:?}", e);
        });

        let mut s = String::new();
        f.read_to_string(&mut s).unwrap_or_else(|e| {
            panic!("read error: {:?}", e)
        });

        let mut res: Vec<String> = Vec::new();
        for line in s.lines() {
            match line {
                "" => continue,
                _  => res.push(line.to_string()),
            }
        }
        res
    }

    fn check_existance_dir(path: &Path) {
        if !path.exists() {
            fs::create_dir(path).unwrap_or_else(|e| {
                panic!("failed to create: {:?}", e);
            });
        }
    }

    fn check_existance(path: &Path) {
        if !path.exists() {
            File::create(path).unwrap_or_else(|e| {
                panic!("failed to create: {:?}", e);
            });
        }
    }
}
