use colored::Colorize;
use std::fs;
use std::io;
use std::io::Write;

use crate::args::Args;
use crate::scanner::SearchResult;

// Test replacer

pub fn perform_replace(args: &Args, result: SearchResult) {
    show_instructions();

    match read_ids() {
        Some(str_ids) => {
            let ids = expand_ids(str_ids.replace("\n", ""), &result);

            replace(&args, &ids, result.clone());
        }
        None => {
            println!("\nAborting!");
        }
    }
}

fn replace(args: &Args, ids: &Vec<u32>, result: SearchResult) {
    result
        .entries
        .iter()
        .filter(|e| ids.contains(&e.id))
        .for_each(|e| {
            let contents =
                fs::read_to_string(e.file.clone()).expect("Should have been able to read the file");

            let mut lines = contents.lines().collect::<Vec<&str>>();

            let new_line = &lines[e.line_index - 1].replace(
                &args.searched_term.clone().unwrap(),
                &args.substitution.clone().unwrap(),
            );

            lines[e.line_index - 1] = new_line;

            let mut new_content = lines.join("\n");
            new_content.push_str("\n");

            fs::write(e.file.clone(), new_content).expect("Should have been able to write to file");
        });
}

fn read_ids() -> Option<String> {
    io::stdout().flush().unwrap();

    let mut user_input = String::new();

    io::stdin()
        .read_line(&mut user_input)
        .expect("error: unable to read user input");

    if user_input == "\n" {
        return None;
    }

    return Some(user_input);
}

fn expand_ids(ids: String, result: &SearchResult) -> Vec<u32> {
    if ids == "a" {
        return result.entries.iter().map(|e| e.id).collect::<Vec<u32>>();
    } else {
        // split by comma
        let collection: Vec<&str> = ids.split(",").collect();

        return collection.iter().flat_map(|&s| expand_range(s)).collect();
    }
}

fn expand_range(value: &str) -> Vec<u32> {
    if value.contains("-") {
        let range: Vec<&str> = value.split("-").collect();

        let start = range[0].parse::<u32>().unwrap();
        let end = range[1].parse::<u32>().unwrap();

        return (start..(end + 1)).collect();
    } else {
        return [value.parse::<u32>().unwrap()].to_vec();
    }
}

fn show_instructions() {
    let a = "a".bold().green();
    let id = "ID".bold().yellow();
    let number_1 = "1".bold().yellow();
    let ids = "IDs".bold().yellow();
    let list_1_2_3 = "1,2,3".bold().yellow();
    let range_3_5 = "3..5".bold().yellow();
    let list_3_4_5 = "3,4,5".bold().yellow();
    let list_1_2_3_10_12_20_25 = "1,2,3,10..12,20..25".bold().yellow();

    println!("Instructions:");
    println!("  Type an \"{a}\" to replace all");
    println!("  Type a single {id} number to replace only that line. example {number_1}");
    println!("  Type a set of {ids} separated by comma, example: {list_1_2_3}");
    println!("  Type an inclusive range using .. to replace a range of IDs, example: {range_3_5} same as to {list_3_4_5}");
    println!("  Conbine {ids} and Ranges freely. example: {list_1_2_3_10_12_20_25}");
    println!("  Type nothing and press Enter to abort");
    println!("");
    print!("Which lines do you want to replace? ");
}
