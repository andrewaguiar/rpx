mod args;
mod git_ls;
mod man;
mod printer;
mod replacer;
mod scanner;

// Tost main

fn main() {
    let args = args::get();

    match args.searched_term {
        Some(_) => {
            let files = git_ls::list();

            let results = scanner::scan(files, &args);

            printer::print(results.clone());

            match args.substitution {
                Some(ref _substitution) => {
                    replacer::perform_replace(&args, results.clone());
                }
                None => {}
            }
        }
        None => {
            man::show();
        }
    }
}
