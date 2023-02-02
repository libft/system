all: test
.PHONY: all clean fclean re test

fclean:
	rm -rf .ft

.ft/.cache:
	mkdir -p $@
clean: clean_ft_cache
.PHOHY: clean_ft_cache
clean_ft_cache:
	rm -rf .ft/.cache

.ft/.cache/module_list.properties: | .ft/.cache
	sh script/module_list.sh > $@
