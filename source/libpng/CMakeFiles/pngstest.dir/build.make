# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake.exe

# The command to remove a file.
RM = /usr/bin/cmake.exe -E remove -f

# Escaping for special characters.
EQUALS = =

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /usr/bin/ccmake.exe

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng

# Include any dependencies generated for this target.
include CMakeFiles/pngstest.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/pngstest.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/pngstest.dir/flags.make

CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o: CMakeFiles/pngstest.dir/flags.make
CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o: contrib/libtests/pngstest.c
	$(CMAKE_COMMAND) -E cmake_progress_report /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o   -c /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng/contrib/libtests/pngstest.c

CMakeFiles/pngstest.dir/contrib/libtests/pngstest.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/pngstest.dir/contrib/libtests/pngstest.i"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng/contrib/libtests/pngstest.c > CMakeFiles/pngstest.dir/contrib/libtests/pngstest.i

CMakeFiles/pngstest.dir/contrib/libtests/pngstest.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/pngstest.dir/contrib/libtests/pngstest.s"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng/contrib/libtests/pngstest.c -o CMakeFiles/pngstest.dir/contrib/libtests/pngstest.s

CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o.requires:
.PHONY : CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o.requires

CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o.provides: CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o.requires
	$(MAKE) -f CMakeFiles/pngstest.dir/build.make CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o.provides.build
.PHONY : CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o.provides

CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o.provides.build: CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o

# Object files for target pngstest
pngstest_OBJECTS = \
"CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o"

# External object files for target pngstest
pngstest_EXTERNAL_OBJECTS =

pngstest.exe: CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o
pngstest.exe: CMakeFiles/pngstest.dir/build.make
pngstest.exe: libpng16.dll.a
pngstest.exe: /usr/lib/libz.dll.a
pngstest.exe: /usr/lib/libm.a
pngstest.exe: CMakeFiles/pngstest.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C executable pngstest.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/pngstest.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/pngstest.dir/build: pngstest.exe
.PHONY : CMakeFiles/pngstest.dir/build

CMakeFiles/pngstest.dir/requires: CMakeFiles/pngstest.dir/contrib/libtests/pngstest.o.requires
.PHONY : CMakeFiles/pngstest.dir/requires

CMakeFiles/pngstest.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/pngstest.dir/cmake_clean.cmake
.PHONY : CMakeFiles/pngstest.dir/clean

CMakeFiles/pngstest.dir/depend:
	cd /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng /cygdrive/c/Users/Mikael/Documents/Reflex/LogicielOrdi/RenderReflex/source/libpng/CMakeFiles/pngstest.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/pngstest.dir/depend
