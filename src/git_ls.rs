use std::process::Command;
use std::process::Stdio;

pub fn list() -> Vec<String> {
    let output = Command::new("git")
        .arg("ls-files")
        .stdout(Stdio::piped())
        .output()
        .unwrap();

    let files = String::from_utf8(output.stdout).unwrap();

    let mut returned_files = Vec::new();

    for file in files.split("\n") {
        if file != "" {
            returned_files.push(file.to_string());
        }
    }

    return returned_files;
}
