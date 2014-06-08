build-tools-cpp
===============

### Build your autotools / CMake / Makefile project in atom

![Error highlighting](https://cloud.githubusercontent.com/assets/7817714/3212315/57e17420-ef53-11e3-8455-8ddb1bd6da5e.png)

## Features
* Tested with autotools, CMake and custom Makefiles
* Highlights errors and warnings of `gcc` and `g++` ( can be disabled, only works with `gcc`/`g++` v4.8+ )
* File paths can be opened with left click


## How to
* Click `ctrl-l ctrl-u` to execute your `Pre-Configure command`
* Click `ctrl-l ctrl-i` to execute your `Configure command`
* Click `ctrl-l ctrl-o` to execute your `Build command`

## Example settings
|Makefile | autotools | cmake | Custom
---|---|---|---|---
Build folder | `.` | `.` | `build` | `.`
Build command | `make` | `make` | `make` | `g++ main.cpp -o hello_world`
Configure command | | `CXXFLAGS="-g -pg" ./configure` | `cmake ..` |
Pre-Configure command | | `autoreconf -ifv` | |
