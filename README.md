# Pitchfork

A set of helper functions to aid in applying [Pitchfork](https://github.com/vector-of-bool/pitchfork)
(a set of C++ project conventions) for CMake.

## Installation

Download the script from the [Releases](https://github.com/jessestricker/releases) page
and save it somewhere in your project's directory.
The following commands do this for your, when run from the project's root directory.

**POSIX Shell:**

```bash
mkdir -p cmake
wget -O cmake/Pitchfork.cmake 'https://github.com/jessestricker/pitchfork/releases/download/v0.1.0/Pitchfork.cmake'
```

**PowerShell:**

```powershell
mkdir -Force cmake
iwr -OutFile cmake/Pitchfork.cmake 'https://github.com/jessestricker/pitchfork/releases/download/v0.1.0/Pitchfork.cmake'
```

After downloading, include the script into your top-level `CMakeLists.txt`.
To do that, put this line after the `project(...)` command:

```cmake
include(cmake/Pitchfork.cmake)
```

## Usage

**Project Layout:**

- `<project-root>`
  - `CMakeLists.txt`
  - `src/`
    - `utils`
      - `utils.hpp`
      - `utils.cpp`
      - `utils.test.cpp`
    - `app.main.cpp`

**Contents of `CMakeLists.txt`:**

```cmake
pf_add_library(utils)
pf_add_executable(app LIBS utils)
```

<!-- TODO: add some explanation -->

## Documentation

**Reference:**

... <!-- TODO -->

**Implementation notes:**

- [Compiler options](./docs/compiler-options.md)
- [Release process](./docs/release-process.md)
