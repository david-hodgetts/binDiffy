# binDiffy

a very simple and naive binary diff cli utility written in zig (basically "cmp -l"). 
given 2 files it outputs each differing byte on a line in the following format:

```
offset byte-file1 byte-file2 
``` 
where *offset* is expressed in decimal and *byte values* are expressed in hex.

## build instructions
```
$ zig build -dRelease-fast=true
```

## usage
```
$ binDiffy file1 file2
```

## license
[MIT](https://opensource.org/licenses/MIT)


