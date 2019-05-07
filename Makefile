IDIR =include
CC=gcc
CXX=g++
CFLAGS=-I$(IDIR)

CPPUTEST_HOME=/usr
CPPFLAGS += -I$(CPPUTEST_HOME)/include
#CXXFLAGS += -include $(CPPUTEST_HOME)/include/CppUTest/MemoryLeakDetectorNewMacros.h
#CFLAGS += -include $(CPPUTEST_HOME)/include/CppUTest/MemoryLeakDetectorMallocMacros.h
LD_LIBRARIES = -L$(CPPUTEST_HOME)/lib -lCppUTest -lCppUTestExt

MKDIR_P = mkdir -p

BDIR=build
ODIR=build/obj
TODIR=build/tobj

LDIR =../lib
SRCDIR=src
TDIR=t

LIBS=-lm

_DEPS = simple.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = main.o simple.o 
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

_TOBJ = main.o simple.o
TOBJ = $(patsubst %,$(TODIR)/%,$(_TOBJ))

$(ODIR)/%.o: $(SRCDIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

$(TODIR)/%.o: $(TDIR)/%.cpp
	$(CXX) -c -o $@ $< $(CPPFLAGS)

main: $(OBJ)
	$(CC) -o $(BDIR)/$@ $^ $(CFLAGS) $(LIBS)

run_tests: $(TOBJ)
	$(CXX) -o $(BDIR)/$@ $^ $(CPPFLAGS) $(LIBS) $(LD_LIBRARIES)

test: directories run_tests
	$(BDIR)/run_tests

all: directories main

.PHONY: clean test directories

clean:
	rm -f $(BDIR)/* $(ODIR)/*.o $(TODIR)/*.o *~ core $(INCDIR)/*~

directories:
	$(MKDIR_P) $(BDIR) $(ODIR) $(TODIR)
