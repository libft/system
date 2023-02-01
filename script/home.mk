all:
	$(MAKE) executable.exe || $(MAKE) library.a
.PHONY: all

OBJS := $(patsubst src/%.c,.cache/%.o,$(SRCS))

CPPFLAGS += -I include

.cache:
	mkdir -p $@
.cache/%.o: src/%.c | .cache
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
executable.exe: $(OBJS)
	$(CC) $(LOADLIBES) $(LDLIBS) $(LDFLAGS) -o $@ $^
library.a: $(OBJS)
	ar cr $@ $^
