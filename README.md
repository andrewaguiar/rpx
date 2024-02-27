# Rpx (simple and extensible string replacer)

Rpx is a tool to provide simple string replacement to GIT controled projects, it is
a `sed` less powerfull but simpler.

## Motivation

Sometimes I wanted to perform some string replacement on several files, I used `sed` for this
but even though it works perfectly I missed some features like:

  - Filtering only git files `git ls-files`.
  - Visual preview of changes.
  - Be able to cherry pick which files / lines would be changed.

So because this I decided to create my own tool for this.

![Example](example.png)

## Installation

Just download the binary in `bin/rpx` and add it to the path

```shell
wget https://raw.githubusercontent.com/andrewaguiar/rpx/master/dist/rpx
chmod +x rpx
```

Or clone the project and make the binary

```shell
git clone git@github.com:andrewaguiar/rpx.git
cd rpx
./make_dist
```

Then add it to PATH

```shell
export PATH="$PATH:rpx_location/dist"
```

## Usage

Type `rpx` to see instructions.

```shell
NAME
       rpx -- simple and powerfull string replacer based on non gitignore files

SYNOPSIS
       rpx <string-to-be-replaced> [replacement] [-f]

DESCRIPTION

       Rpx scans all git ls-files recursively and shows all occurences of <string-to-be-replaced> in each file, then it
       asks for confirmation before replace all occurrences by <replacement>.

       The following options are available:

       --filename | -f
              Filters by absolute path name in any part (defaults '').

              Example: "rpx AppController ApplicationController -f controllers" will consider only files with controllers
                       in absolute path like ("app/controllers/app_controllers.rb", "config/controllers.rb").
```

### Creating a bin

run `./make_dist` and the binary will be generated in `./dist`.
