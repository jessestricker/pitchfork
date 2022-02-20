# ensure minimum version requirements are met
cmake_minimum_required(VERSION 3.20 FATAL_ERROR)
if(MSVC AND MSVC_VERSION LESS 1910)
  message(FATAL_ERROR "Pitchfork for MSVC requires Visual Studio 2017")
endif()

function(_pf_dbg_print message)
  message(DEBUG "[PF][${target}] ${message}")
endfunction()

function(_pf_dbg_var name)
  list(LENGTH ${name} list_length)
  if(list_length GREATER 1)
    _pf_dbg_print("\${${name}} = ")
    foreach(item ${${name}})
      _pf_dbg_print("  ${item}")
    endforeach()
  else()
    _pf_dbg_print("\${${name}} = ${${name}}")
  endif()
endfunction()

function(_pf_add_build_reqs target)
  # Microsoft Visual C++
  if(MSVC)
    # conformance
    target_compile_options(${target} PRIVATE /Zc:throwingNew)
    target_compile_options(${target} PRIVATE /Zc:strictStrings)
    target_compile_options(${target} PRIVATE /Zc:inline)
    target_compile_options(${target} PRIVATE /permissive-)
    if(MSVC_VERSION GREATER_EQUAL 1912)
      target_compile_options(${target} PRIVATE /Zc:ternary)
    endif()
    if(MSVC_VERSION GREATER_EQUAL 1913)
      target_compile_options(${target} PRIVATE /Zc:externConstexpr)
    endif()
    if(MSVC_VERSION GREATER_EQUAL 1914)
      target_compile_options(${target} PRIVATE /Zc:__cplusplus)
    endif()
    if(MSVC_VERSION GREATER_EQUAL 1925)
      target_compile_options(${target} PRIVATE /Zc:preprocessor)
    endif()
    if(MSVC_VERSION GREATER_EQUAL 1928)
      target_compile_options(${target} PRIVATE /Zc:lambda)
    endif()

    # performance
    target_compile_options(${target} PRIVATE /arch:AVX)
    target_compile_options(${target} PRIVATE /arch:AVX2)
    if(MSVC_VERSION GREATER_EQUAL 1920)
      target_compile_options(${target} PRIVATE $<$<CONFIG:Release>:/Ob3>)
    endif()
  endif()
endfunction()

function(pf_add_library target)
  # parse optional args
  cmake_parse_arguments(_arg "" "STANDARD" "LIBS;PRIVATE_LIBS" ${ARGN})
  _pf_dbg_var(_arg_STANDARD)
  _pf_dbg_var(_arg_LIBS)
  _pf_dbg_var(_arg_PRIVATE_LIBS)

  # construct target-specific paths
  cmake_path(SET source_dir NORMALIZE "${PROJECT_SOURCE_DIR}/src/${target}")
  cmake_path(GET source_dir PARENT_PATH include_dir)
  _pf_dbg_var(source_dir)
  _pf_dbg_var(include_dir)

  # find source files
  file(
    GLOB_RECURSE sources
    LIST_DIRECTORIES false
    CONFIGURE_DEPENDS "${source_dir}/*.cpp")
  file(
    GLOB_RECURSE test_sources
    LIST_DIRECTORIES false
    CONFIGURE_DEPENDS "${source_dir}/*.test.cpp")
  list(REMOVE_ITEM sources "${test_sources}")
  _pf_dbg_var(sources)
  _pf_dbg_var(test_sources)

  # add static library target and alias
  set(alias_target ${PROJECT_NAME}::${target})
  add_library(${target} STATIC "${sources}")
  add_library(${alias_target} ALIAS ${target})
  _pf_dbg_print("Added library target \"${target}\" with alias \"${alias_target}\"")

  # set target properties
  target_include_directories(${target} PUBLIC ${include_dir})
  if(DEFINED _arg_STANDARD)
    target_compile_features(${target} PUBLIC cxx_std_${_arg_STANDARD})
  endif()
  target_link_libraries(
    ${target}
    PUBLIC "${_arg_LIBS}"
    PRIVATE "${_arg_PRIVATE_LIBS}")
  _pf_add_build_reqs(${target})
endfunction()

function(pf_add_example target)
  # TODO
endfunction()

# print build system information
_pf_dbg_var(CMAKE_CXX_COMPILER_ID)
_pf_dbg_var(CMAKE_CXX_COMPILER_VERSION)
if(MSVC)
  _pf_dbg_var(MSVC_TOOLSET_VERSION)
  _pf_dbg_var(MSVC_VERSION)
endif()
