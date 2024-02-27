use clap::Parser;

#[derive(Parser, Debug)]
#[command(long_about = None)]
pub struct Args {
    pub searched_term: Option<String>,

    pub substitution: Option<String>,

    #[arg(short, long)]
    pub filename: Option<String>,

    #[arg(short, long)]
    pub regex: bool,
}

pub fn get() -> Args {
    return Args::parse();
}
