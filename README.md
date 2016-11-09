# Alpine Sharp
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE)

Installs [libvips](https://pkgs.alpinelinux.org/packages?name=vips*&branch=&repo=&arch=&maintainer=) **8.3.3** and [sharp](https://github.com/lovell/sharp) inside of an [Alpine](https://alpinelinux.org/) container.

This repository makes the following assumptions

* You already have a package.json with all your dependencies and code
* You have private NPM modules you are pulling
* You have used `make`
* You have used Alpine Linux
* You have `docker` installed

- - - -
# How to hack away with this project

1. Write some code
1. Type `make build`
1. Run your new container via `docker run -d $CID`
1. Verify your container is running via `docker ps`
1. Break it
1. Fix it
1. Rinse repeat

- - - -
# License

MIT

(c) 2016 GreenLancer.com
