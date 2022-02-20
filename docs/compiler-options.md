# Compiler Options

Performance options are enabled if they're generally applicable
and do not compromise on safety, precision, correctness or conformance.
Some performance options require specific hardware.
The following sources may be consulted to check the availability of this hardware.

- [Steam Hardware Survey](https://store.steampowered.com/hwsurvey)

## Microsoft Visual C++

**Release Notes:**

- [Visual Studio](https://docs.microsoft.com/en-us/visualstudio/releases/2022/release-notes)
- [MSVC](https://docs.microsoft.com/en-us/cpp/overview/what-s-new-for-visual-cpp-in-visual-studio)

**Documentation:**

- [MSVC: Compiler options](https://docs.microsoft.com/en-us/cpp/build/reference/compiler-options-listed-by-category)
- [MSVC: Predefined macros](https://docs.microsoft.com/en-us/cpp/preprocessor/predefined-macros)

The default options applied by CMake are:

- always: `/nologo /TP /showIncludes /FS -c`
- debug: `/DWIN32 /D_WINDOWS /EHsc /Zi /Ob0 /Od /RTC1 -MDd`
- release: `/DWIN32 /D_WINDOWS /EHsc /O2 /Ob2 /DNDEBUG -MD`

(as of CMake v22.2.2, Visual Studion 2022 update v17.0.6, Compiler v19.30.30709)

The following sections list compiler options which are not enabled by default in supported every version.
Although some version requirements list versions prior to VS 2017, this will be the minimally supported version by Pitchfork.

### Conformance

| Option                | Requirements                        |
| --------------------- | ----------------------------------- |
| `/Zc:throwingNew`     | \>= Visual Studio 2002              |
| `/Zc:strictStrings`   | \> Visual Studio 2013               |
| `/Zc:inline`          | \>= Visual Studio 2013 Update 2     |
| `/permissive-`        | \>= Visual Studio 2017              |
| `/Zc:ternary`         | \>= Visual Studio 2017 version 15.5 |
| `/Zc:externConstexpr` | \>= Visual Studio 2017 version 15.6 |
| `/Zc:__cplusplus`     | \>= Visual Studio 2017 version 15.7 |
| `/Zc:preprocessor`    | \>= Visual Studio 2019 version 16.5 |
| `/Zc:lambda`          | \>= Visual Studio 2019 version 16.8 |

### Performance

| Option       | Debug | Release | Requirements                                         |
| ------------ | :---: | :-----: | ---------------------------------------------------- |
| `/arch:AVX`  |   ✓   |    ✓    | none                                                 |
| `/arch:AVX2` |   ✓   |    ✓    | \> Visual Studio 2013 Update 2, version 12.0.34567.1 |
| `/Ob3`       |       |    ✓    | \>= Visual Studio 2019                               |

## GNU Compiler Collection

<!-- TODO -->

## LLVM Clang

Same as GNU Compiler Collection.
