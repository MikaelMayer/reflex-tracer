##### Variables

SRCDIR = ../source ../source/complexlib ../source/libpng
INCDIR = -I/usr/include -I../source -I../source/complexlib
CPPFLAGS = -g -Wall -W $(INCDIR)
LFLAGS = -lm -lpthread -L./ -lcygpng16-16 -Wl,--as-needed
CC = g++

##### Files

SOURCES = $(wildcard *.cpp, wildcard *.h)
OBJECTS = $(patsubst %.cpp,%.o,$(wildcard *.cpp))
TARGET = RenderReflex

##### Build rules

all: $(OBJECTS)
	$(CC) $(CPPFLAGS) $(OBJECTS) $(LFLAGS) -o $(TARGET)
	cp ./RenderReflex.exe c:/Users/Mikael/Dropbox/Reflex/Reflex\ Tracer/ReflexRenderer3.0\ beta/Release
	cp ./RenderReflex.exe ../../reflex4you/exe
	cp ../source/complexlib/* ../../reflex4you/software/complexlib
	cp ../source/RenderReflex.cpp ../../reflex4you/software
	
# -exec ln -s {} \; ; done
import:
	@rm -f *.cpp *~
	@rm -f *.h *~
	@rm -f *.o *~
	@rm -f *.dll *~
	@for dir in ../source; do find $$dir -name \*.cpp -exec cp {} . \; ; done
	@for dir in ../source; do find $$dir -name \*.h -exec cp {} . \;  ; done
	@for dir in ../source; do find $$dir -name \*.o -exec cp {} . \;  ; done
	@for dir in ../source; do find $$dir -name \*.dll -exec cp {} . \;  ; done

depend:
	@makedepend $(INCDIR) -Y -m $(SOURCES) 2> /dev/null

clean:
	@rm -f *.o *.bak *.cpp *~ *%

##### End of Makefile
# DO NOT DELETE

zfstream.o: zlib.h zconf.h
pngstruct.o: zlib.h zconf.h
lexeme.o: complex.h /usr/include/math.h /usr/include/sys/reent.h
lexeme.o: /usr/include/_ansi.h /usr/include/newlib.h
lexeme.o: /usr/include/sys/config.h /usr/include/machine/ieeefp.h
lexeme.o: /usr/include/sys/features.h /usr/include/sys/_types.h
lexeme.o: /usr/include/machine/_types.h /usr/include/machine/_default_types.h
lexeme.o: /usr/include/sys/lock.h functions.h functionFactory.h
lexeme.o: /usr/include/stdlib.h /usr/include/machine/stdlib.h
lexeme.o: /usr/include/alloca.h
PngFile.o: /usr/include/stdio.h /usr/include/_ansi.h /usr/include/newlib.h
PngFile.o: /usr/include/sys/config.h /usr/include/machine/ieeefp.h
PngFile.o: /usr/include/sys/features.h /usr/include/sys/cdefs.h
PngFile.o: /usr/include/machine/_default_types.h /usr/include/sys/reent.h
PngFile.o: /usr/include/sys/_types.h /usr/include/machine/_types.h
PngFile.o: /usr/include/sys/lock.h /usr/include/sys/types.h
PngFile.o: /usr/include/machine/types.h /usr/include/sys/stdio.h
PngFile.o: /usr/include/stdlib.h /usr/include/machine/stdlib.h
PngFile.o: /usr/include/alloca.h /usr/include/string.h
PngFile.o: /usr/include/sys/string.h
deflate.o: zutil.h zlib.h zconf.h /usr/include/string.h /usr/include/_ansi.h
deflate.o: /usr/include/newlib.h /usr/include/sys/config.h
deflate.o: /usr/include/machine/ieeefp.h /usr/include/sys/features.h
deflate.o: /usr/include/sys/reent.h /usr/include/sys/_types.h
deflate.o: /usr/include/machine/_types.h
deflate.o: /usr/include/machine/_default_types.h /usr/include/sys/lock.h
deflate.o: /usr/include/sys/cdefs.h /usr/include/sys/string.h
deflate.o: /usr/include/stdlib.h /usr/include/machine/stdlib.h
deflate.o: /usr/include/alloca.h /usr/include/errno.h
deflate.o: /usr/include/sys/errno.h
funcalea.o: functions.h complex.h /usr/include/math.h
funcalea.o: /usr/include/sys/reent.h /usr/include/_ansi.h
funcalea.o: /usr/include/newlib.h /usr/include/sys/config.h
funcalea.o: /usr/include/machine/ieeefp.h /usr/include/sys/features.h
funcalea.o: /usr/include/sys/_types.h /usr/include/machine/_types.h
funcalea.o: /usr/include/machine/_default_types.h /usr/include/sys/lock.h
zip.o: zlib.h zconf.h ioapi.h
pngconf.o: /usr/include/limits.h /usr/include/features.h
pngconf.o: /usr/include/sys/cdefs.h /usr/include/machine/_default_types.h
pngconf.o: /usr/include/sys/features.h /usr/include/bits/wordsize.h
functions.o: complex.h /usr/include/math.h /usr/include/sys/reent.h
functions.o: /usr/include/_ansi.h /usr/include/newlib.h
functions.o: /usr/include/sys/config.h /usr/include/machine/ieeefp.h
functions.o: /usr/include/sys/features.h /usr/include/sys/_types.h
functions.o: /usr/include/machine/_types.h
functions.o: /usr/include/machine/_default_types.h /usr/include/sys/lock.h
png.o: pnglibconf.h pngconf.h /usr/include/limits.h /usr/include/features.h
png.o: /usr/include/sys/cdefs.h /usr/include/machine/_default_types.h
png.o: /usr/include/sys/features.h /usr/include/bits/wordsize.h
functionFactory.o: functions.h complex.h /usr/include/math.h
functionFactory.o: /usr/include/sys/reent.h /usr/include/_ansi.h
functionFactory.o: /usr/include/newlib.h /usr/include/sys/config.h
functionFactory.o: /usr/include/machine/ieeefp.h /usr/include/sys/features.h
functionFactory.o: /usr/include/sys/_types.h /usr/include/machine/_types.h
functionFactory.o: /usr/include/machine/_default_types.h
functionFactory.o: /usr/include/sys/lock.h
stdafx.o: /usr/include/stdio.h /usr/include/_ansi.h /usr/include/newlib.h
stdafx.o: /usr/include/sys/config.h /usr/include/machine/ieeefp.h
stdafx.o: /usr/include/sys/features.h /usr/include/sys/cdefs.h
stdafx.o: /usr/include/machine/_default_types.h /usr/include/sys/reent.h
stdafx.o: /usr/include/sys/_types.h /usr/include/machine/_types.h
stdafx.o: /usr/include/sys/lock.h /usr/include/sys/types.h
stdafx.o: /usr/include/machine/types.h /usr/include/sys/stdio.h
stdafx.o: /usr/include/stdlib.h /usr/include/machine/stdlib.h
stdafx.o: /usr/include/alloca.h /usr/include/string.h
stdafx.o: /usr/include/sys/string.h tchar.h
cexcept.o: /usr/include/setjmp.h /usr/include/_ansi.h /usr/include/newlib.h
cexcept.o: /usr/include/sys/config.h /usr/include/machine/ieeefp.h
cexcept.o: /usr/include/sys/features.h /usr/include/machine/setjmp.h
pngpriv.o: /usr/include/stdlib.h /usr/include/machine/ieeefp.h
pngpriv.o: /usr/include/_ansi.h /usr/include/newlib.h
pngpriv.o: /usr/include/sys/config.h /usr/include/sys/features.h
pngpriv.o: /usr/include/sys/reent.h /usr/include/sys/_types.h
pngpriv.o: /usr/include/machine/_types.h
pngpriv.o: /usr/include/machine/_default_types.h /usr/include/sys/lock.h
pngpriv.o: /usr/include/machine/stdlib.h /usr/include/alloca.h
pngpriv.o: /usr/include/string.h /usr/include/sys/cdefs.h
pngpriv.o: /usr/include/sys/string.h pnglibconf.h png.h pngconf.h
pngpriv.o: /usr/include/limits.h /usr/include/features.h
pngpriv.o: /usr/include/bits/wordsize.h /usr/include/math.h pngstruct.h
pngpriv.o: zlib.h zconf.h pnginfo.h pngdebug.h
unzip.o: zlib.h zconf.h ioapi.h
complex.o: /usr/include/math.h /usr/include/sys/reent.h /usr/include/_ansi.h
complex.o: /usr/include/newlib.h /usr/include/sys/config.h
complex.o: /usr/include/machine/ieeefp.h /usr/include/sys/features.h
complex.o: /usr/include/sys/_types.h /usr/include/machine/_types.h
complex.o: /usr/include/machine/_default_types.h /usr/include/sys/lock.h
lexeur.o: lexeme.h complex.h /usr/include/math.h /usr/include/sys/reent.h
lexeur.o: /usr/include/_ansi.h /usr/include/newlib.h
lexeur.o: /usr/include/sys/config.h /usr/include/machine/ieeefp.h
lexeur.o: /usr/include/sys/features.h /usr/include/sys/_types.h
lexeur.o: /usr/include/machine/_types.h /usr/include/machine/_default_types.h
lexeur.o: /usr/include/sys/lock.h functions.h functionFactory.h
lexeur.o: /usr/include/stdlib.h /usr/include/machine/stdlib.h
lexeur.o: /usr/include/alloca.h
mztools.o: zlib.h zconf.h unzip.h ioapi.h
zutil.o: zlib.h zconf.h /usr/include/string.h /usr/include/_ansi.h
zutil.o: /usr/include/newlib.h /usr/include/sys/config.h
zutil.o: /usr/include/machine/ieeefp.h /usr/include/sys/features.h
zutil.o: /usr/include/sys/reent.h /usr/include/sys/_types.h
zutil.o: /usr/include/machine/_types.h /usr/include/machine/_default_types.h
zutil.o: /usr/include/sys/lock.h /usr/include/sys/cdefs.h
zutil.o: /usr/include/sys/string.h /usr/include/stdlib.h
zutil.o: /usr/include/machine/stdlib.h /usr/include/alloca.h
zutil.o: /usr/include/errno.h /usr/include/sys/errno.h
zlib.o: zconf.h
