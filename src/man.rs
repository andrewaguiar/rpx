use colored::Colorize;

pub fn show() {
    let (name, synopsis, description, filename, regex) = (
        "NAME".bold(),
        "SYNOPSIS".bold(),
        "DESCRIPTION".bold(),
        "--filename | -f".bold(),
        "--regex | -r".bold(),
    );

    println!("{name}");
    println!("       rpx -- simple and powerfull string replacer based on non gitignore files");
    println!("");
    println!("{synopsis}");
    println!("       rpx <string-to-be-replaced> [replacement] [-r]");
    println!("");
    println!("{description}");
    println!("");
    println!("       Rpx scans all git ls-files recursively and shows all occurences of <string-to-be-replaced> in each file, then it");
    println!("       asks for confirmation before replace all occurrences by <replacement>.");
    println!("");
    println!("       The following options are available:");
    println!("");
    println!("       {filename}");
    println!("              Filters by absolute path name in any part (defaults '').");
    println!("");
    println!("              Example: \"rpx AppController ApplicationController -f controllers\" will consider only files with controllers");
    println!("                       in absolute path like (\"app/controllers/app_controllers.rb\", \"config/controllers.rb\").");
    println!("");
    println!("       {regex}");
    println!("              Treats the <string-to-be-replaced> as a regex instead of a simple text (default false).");
    println!("");
}
