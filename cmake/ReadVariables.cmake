# Simple CMake utility to read variables from MK files
#   - Gets contents from given file (name or path)
#   - Parses the assignment statements
#   - Makes the same assignments in the PARENT_SCOPE

if(POLICY CMP0007)
  cmake_policy(SET CMP0007 NEW)
endif()

function(ReadVariables MKFile)
  file(READ "${MKFile}" FileContents)
  string(REGEX REPLACE "\\\\\n *" " " FileContents ${FileContents})
  string(REGEX REPLACE "#[^\n]*" "" FileContents ${FileContents})
  string(STRIP FileContents ${FileContents})
  string(REPLACE "\n" ";" FileLines ${FileContents})
  list(REMOVE_ITEM FileLines "")
  foreach(line ${FileLines})
    string(REGEX REPLACE ":?=" ";" line_split ${line})
    list(LENGTH line_split count)
    if (count LESS 2)
      message(STATUS "Skipping ${line}")
      continue()
    endif()
    list(GET line_split -1 value)
    string(STRIP ${value} value)
    string(REGEX REPLACE " +" " " value "${value}")
    separate_arguments(value)
    list(REMOVE_AT line_split -1)
    foreach(var_name ${line_split})
      string(STRIP ${var_name} var_name)
      set(${var_name} ${value} PARENT_SCOPE)
    endforeach()
  endforeach()
endfunction()