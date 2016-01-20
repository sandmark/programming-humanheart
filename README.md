Programming Human-Heart
-----------------------

An implementation of a book named [Programming Human Heart ~Let's build a ChatterBot with Ruby](https://books.google.com/books?id=oaK_BQAAQBAJ)(Japanese), written in Ruby.

## Dependency
`proto` needs [MeCab](http://taku910.github.io/mecab/) and [natto](https://github.com/buruzaemon/natto). Internal encoding is UTF-8 so it works perfectly in Unix-like OS when env `LANG` is set to `ja_JP.UTF-8`, but on Windows, `MeCab` must be installed with **ShiftJIS** dictionaries if you're using native ruby, unless Cygwin or sorts.

Moreover, `MeCab` doesn't release 64bit binaries for Windows, only 32bit. When your Windows and Ruby is built 64bit, `natto` will fail to load `MeCab` library. To avoid this, build 64bit `libmecab.dll` by your hand ([Reading this document](https://github.com/buruzaemon/natto/wiki/64-Bit-Windows) will help you) or use pre-built 64bit `libmecab.dll` I made on [here](https://drive.google.com/file/d/0BxfuPclLjJDtZTFZNnhWS18xMFE/view?usp=sharing).

## Usage
### Windows
Just double-click `proto.rb`.

### Mac OS X or Unix-like OS
In the terminal, type `./proto.rb` or `ruby proto.rb` and it works.

## Why chatterbot in this modern era?

The author, TOMOTOSHI Akiyama who made a chatting software TAKIBI, is gone in 36 years old on 18 Feb, 2005. However, his skills and techniques has been left by himself like this. Making and tweaking my own chatter bot AI is one of my very best dreams since I was just a little lad..., "if I had a my own (weak) AI, what could I do for *him*?" I wondered and dreamed, countless times.

This book will teach HOWTOs of making chatter bot to readers. For me, that should be my second heart.

Implementing this in other languages or tweaking harder in Ruby? It'll be shown in the near future.

Thanks to Akiyama-san, rest in peace.
