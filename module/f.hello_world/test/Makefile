all: test
.PHONY: all clean fclean re test

SRCS := src/main.c

all test: prelude
.PHONY: prelude
prelude:
	< dependencies.txt xargs -L1 sh $(FT_BASE_PATH)/script/load_module_recursive.sh
	sh $(FT_BASE_PATH)/script/build_home.sh $(SRCS)
	(cd .ft/home && $(MAKE) executable.exe)
