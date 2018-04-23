# Rpx (simple and extensible string replacer)

Rpx is a tool to provide simple and extensible string replacement to projects, it is
a `sed` less powerfull but simpler and already adapted to several project archtypes.

## Installation

Just download the binary in `bin/rpx` and add it to the path

## Usage

Type `rpx` to see instructions.

```
NAME
      rpx -- simple and powerfull string replacer

SYNOPSIS
      rpx <string-to-be-replaced> <replacement> [-pxa]

DESCRIPTION

      Rpx scans all allowed files recursively and shows all occurences of <string-to-be-replaced> in each file, then it
      asks for confirmation before replace all occurrences by <replacement>.

      The following options are available:

      --path | -p      The base path rpx will start analyzing recursively (default `.`)
      --ext | -x       The file extentions (comma separated) allowed to be analyzed (default see `~/.rpx.iex`)
      --all | -a       Replaces all found occurences without asking.

```

### Creating a bin

run `./make_dist` and the binary will be generated in `./bin`.
