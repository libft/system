all: test
.PHONY: all clean fclean re test

SRCS := src/main.c

all test: prelude
.PHONY: prelude
prelude:
	sh $(FT_BASE_PATH)/script/resolve.sh
	sh $(FT_BASE_PATH)/script/build_home.sh $(SRCS) $(INCS)
	(cd .ft/home && $(MAKE) executable.exe)

fclean:
	rm -rf .ft
