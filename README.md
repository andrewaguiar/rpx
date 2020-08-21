# Rpx (simple and extensible string replacer)

Rpx is a tool to provide simple and extensible string replacement to projects, it is
a `sed` less powerfull but simpler and already adapted to several project archtypes.

![Example](example.png)

## Installation

Just download the binary in `bin/rpx` and add it to the path

```shell
wget https://raw.githubusercontent.com/andrewaguiar/rpx/master/bin/rpx
chmod +x rpx
```

Or clone the project and make the binary

```shell
git clone git@github.com:andrewaguiar/rpx.git
cd rpx
mix escript.build
```

Then add it to PATH

```shell
export PATH="$PATH:rpx_location"
```

## Usage

Type `rpx` to see instructions.

```shell
NAME
       rpx -- simple and powerfull string replacer

SYNOPSIS
       rpx <string-to-be-replaced> <replacement> [base-path] [-xar]

DESCRIPTION

       Rpx scans all allowed files recursively and shows all occurences of <string-to-be-replaced> in each file, then it
       asks for confirmation before replace all occurrences by <replacement>.

       The following options are available:

       --regex | -r
              Treats the <string-to-be-replaced> as a regex instead of a simple text (default false).
```

### Creating a bin

run `./make_dist` and the binary will be generated in `./bin`.
