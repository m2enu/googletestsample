MAKEFLAGS       += --no-builtin-rules
CC              := gcc
CFLAGS          := -std=c99 -Wall -Wextra -MMD -MP
LDFLAGS         :=
LIBS            :=
DIR_SRC         := src
DIR_OBJ         := obj
DIR_SRCS        := $(shell find $(DIR_SRC) -type d)
INCLUDE         := $(foreach dir,$(DIR_SRCS),-I$(dir))
SRC_EXCLUDES    :=
SRC_TARGETS     := $(foreach dir,$(DIR_SRCS),$(wildcard $(dir)/*.c))
SRCS            := $(filter-out $(SRC_EXCLUDES),$(SRC_TARGETS))
OBJS            := $(addprefix $(DIR_OBJ)/,$(SRCS:.c=.o))
DEPS            := $(OBJS:.o=.d)
TARGET          := $(notdir $(shell pwd)).o
RM              := rm -rf

# tests
CXX             := g++
CXXFLAGS        := -std=c++11 -Wall
LIBS_TST        := -lpthread -lgtest -lgtest_main
DIR_TST         := test
DIR_TSTS        := $(shell find $(DIR_TST) -type d)
INCLUDE_TST     := $(foreach dir,$(DIR_TSTS),-I$(dir))
INCLUDE_TST     += $(INCLUDE)
TSTS            := $(foreach dir,$(DIR_TSTS),$(wildcard $(dir)/*.cpp))
OBJS_TST        := $(addprefix $(DIR_OBJ)/,$(TSTS:.cpp=.o))
DEPS_TST        := $(OBJS_TST:.o=.d)

all: $(TARGET)
	@[ -f $(TARGET) ] && ./$(TARGET)

clean:
	$(RM) $(DIR_OBJ)/* $(TARGET)

$(TARGET): $(OBJS) $(OBJS_TST)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(LIBS_TST)

$(DIR_OBJ)/%.o: %.c
	@[ -d `dirname $@` ] || mkdir -p `dirname $@`
	$(CC) -o $@ -c $< $(CFLAGS) $(INCLUDE)

$(DIR_OBJ)/%.o: %.cpp
	@[ -d `dirname $@` ] || mkdir -p `dirname $@`
	$(CXX) -o $@ -c $< $(CXXFLAGS) $(INCLUDE_TST)

ifneq ($(MAKECMDGOALS), clean)
-include $(DEPS)
endif

.PHONY: all clean

# end of file {{{1
# vim:ft=make:noet:ts=4:nowrap:fdm=marker
