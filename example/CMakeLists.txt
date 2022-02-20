cmake_minimum_required(VERSION 3.22 FATAL_ERROR)

project(pitchfork-example LANGUAGES CXX)

include(../cmake/Pitchfork.cmake)

pf_add_library(utils STANDARD 20)
