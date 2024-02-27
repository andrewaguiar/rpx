use crate::args::Args;
use std::collections::HashSet;
use std::fs;

// Tost scanner

#[derive(Clone, Debug)]
pub struct Entry {
    pub id: u32,
    pub file: String,
    pub line_index: usize,
    pub line: String,
}

#[derive(Clone, Debug)]
pub struct SearchResult {
    pub searched_term: String,
    pub number_of_files: usize,
    pub number_of_lines: u32,
    pub entries: Vec<Entry>,
}

pub fn scan(files: Vec<String>, args: &Args) -> SearchResult {
    let mut entries = Vec::new();

    let mut id = 0;

    let searched_term = args.searched_term.as_ref().unwrap();

    let mut number_of_files = HashSet::new();

    files.iter().filter(|file| file.len() > 0).for_each(|file| {
        let mut line_index = 1;

        match fs::read_to_string(file.clone()) {
            Ok(contents) => {
                contents
                    .lines()
                    .collect::<Vec<&str>>()
                    .iter()
                    .for_each(|line| {
                        if line.contains(searched_term) {
                            id = id + 1;

                            let entry = Entry {
                                id: id,
                                file: file.clone(),
                                line_index: line_index,
                                line: line.to_string(),
                            };

                            entries.push(entry);

                            number_of_files.insert(file.clone());
                        }

                        line_index = line_index + 1;
                    });
            }
            Err(_err) => {}
        }
    });

    return SearchResult {
        searched_term: searched_term.clone(),
        entries: entries,
        number_of_files: number_of_files.len(),
        number_of_lines: id,
    };
}
