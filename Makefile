##### Variables

SRCDIR = .. ../complexlib ../libpng
INCDIR = -I/usr/include -I.. -I../complexlib -I../libpng
CPPFLAGS = -g -Wall -W $(INCDIR) 
LFLAGS = -lm -lpthread
CC = g++

##### Files

SOURCES = $(wildcard *.cpp, wildcard *.h)
OBJECTS = $(patsubst %.cpp,%.o,$(wildcard *.cpp))
TARGET = ReflexRenderer

##### Build rules

all: $(OBJECTS)
	$(CC) $(CPPFLAGS) $(OBJECTS) $(LFLAGS) -o $(TARGET)

import:
	@rm -f *.cpp *~
	@for dir in $(SRCDIR); do find $$dir -name \*.cpp -exec ln -s {} \; ; done
	@for dir in $(SRCDIR); do find $$dir -name \*.h -exec ln -s {} \; ; done

depend:
	@makedepend $(INCDIR) -Y -m $(SOURCES) 2> /dev/null

clean:
	@rm -f *.o *.bak *~ *%

##### End of Makefile
# DO NOT DELETE