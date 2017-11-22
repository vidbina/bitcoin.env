# Usage

## Nix

These instructions should assist in setting up a NixOS shell, capable of building the bitcoin project.

 - git clone [bitcoin](https://github.com/bitcoin/bitcoin)
 - copy or symlink default.nix in this repository into the bitcoin directory
 - `nix-shell` :wink: inside the bitcoin directory

## Docker

These instructions should assist in setting up a Docker environment within which one may mount the bitcoin project in order to build it.

 - build docker image with `make image`
 - start docker container with `BITCOIN=/path/to/bitcoin/repository make shell`

Inside the shell, one may subsequently run

```bash
make clean
./autogen.sh
./configure
make
```

to build the bitcoin code.
