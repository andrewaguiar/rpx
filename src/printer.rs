use colored::Colorize;

use crate::scanner::SearchResult;

pub fn print(result: SearchResult) {
    let id = "ID".bold().yellow();
    let file = "FILE".bold().green();
    let line = "LINE".bold().cyan();
    let term = "TERM".bold().red();

    println!("{id} :: {file} {line} -> TEXT WITH THE {term}\n");

    let searched_term = result.searched_term;

    for entry in result.entries {
        let id = entry.id.to_string().bold().yellow();
        let file = entry.file.bold().green();
        let line_index = entry.line_index.to_string().bold().cyan();

        let line = entry.line;

        let highlighted_line =
            line.replace(&searched_term, &searched_term.bold().red().to_string());

        println!("{id} :: {file} {line_index} -> {highlighted_line}");
    }

    let number_of_files = result.number_of_files.to_string().bold().green();
    let number_of_lines = result.number_of_lines.to_string().bold().green();

    println!("\n{number_of_files} files and {number_of_lines} lines found\n");
}
