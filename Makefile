MAKEFLAGS       += --no-builtin-rules
CC              := gcc
CXX             := g++
MK              := mkdir -p
RM              := rm -rf
MAKE            := make

CFLAGS          := -std=c99 -Wall -Wextra -MMD -MP
CXXFLAGS        := -std=c++11 -Wall
LDFLAGS         := -pthread

DIR_SRC         := src
DIR_OBJ         := obj
DIR_TST         := test
DIR_LIB         := gtest
INCLUDE         := $(addprefix -I, \
  $(shell find $(DIR_SRC) -type d) \
  $(shell find $(DIR_TST) -type d) \
  $(DIR_LIB))

SRCS            := \
  $(shell find $(DIR_SRC) -name "*.c" -or -name "*.cpp" -or -name "*.cc") \
  $(shell find $(DIR_TST) -name "*.c" -or -name "*.cpp" -or -name "*.cc") \
  $(shell find $(DIR_LIB) -name "*.c" -or -name "*.cpp" -or -name "*.cc") \

OBJS            := $(addprefix $(DIR_OBJ)/,$(addsuffix .o,$(SRCS)))
DEPS            := $(OBJS:.o=.d)

TARGET          := $(notdir $(shell pwd)).o

all: $(TARGET)

clean:
	$(RM) $(DIR_OBJ) $(TARGET)

unittest: $(TARGET)
	-./$(TARGET)

setup:
	@$(MAKE) -f Makefile.googletest $@ DIR_LIB=$(DIR_LIB)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^

$(DIR_OBJ)/%.c.o: %.c
	@$(MK) $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDE) -o $@ -c $<

$(DIR_OBJ)/%.cpp.o: %.cpp
	@$(MK) $(dir $@)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -o $@ -c $<

$(DIR_OBJ)/%.cc.o: %.cc
	@$(MK) $(dir $@)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -o $@ -c $<

ifneq ($(MAKECMDGOALS), clean)
-include $(DEPS)
endif

.PHONY: all clean unittest setup

# end of file {{{1
# vim:ft=make:noet:ts=4:nowrap:fdm=marker
