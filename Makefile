all: test
.PHONY: all clean fclean re test

fclean:
	rm -rf .ft

.PHONY: prelude clean_common
all test: prelude
clean fclean: clean_common

.ft/.cache:
	mkdir -p $@
clean: clean_ft_cache
.PHOHY: clean_ft_cache
clean_ft_cache:
	rm -rf .ft/.cache

prelude: refresh_include
.PHOHY: refresh_include
refresh_include .ft/include: refresh_module_list | .ft/.cache
	FT_BASE_PATH="$$(pwd)" sh script/include.sh

prelude: refresh_module_list
.PHOHY: refresh_module_list
refresh_module_list .ft/.cache/module_list.properties: | .ft/.cache
	sh script/module_list.sh > .ft/.cache/module_list.properties
clean: clean_module_list
.PHOHY: clean_module_list
clean_module_list:
	rm -f .ft/.cache/module_list.properties

prelude: refresh_test_list
.PHOHY: refresh_test_list
refresh_test_list .ft/.cache/test_list.properties: | .ft/.cache
	sh script/find_tests.sh > .ft/.cache/test_list.properties
clean: clean_test_list
.PHOHY: clean_test_list
clean_test_list:
	rm -f .ft/.cache/test_list.properties

clean: run_clean_script
.PHONY: run_clean_script
run_clean_script:
	FT_BASE_PATH="$$(pwd)" sh script/run_all_without_cache.sh clean

fclean: run_fclean_script
.PHONY: run_fclean_script
run_fclean_script:
	FT_BASE_PATH="$$(pwd)" sh script/run_all_without_cache.sh fclean

test:
	FT_BASE_PATH="$$(pwd)" sh script/run_all.sh test

re:
	$(MAKE) fclean
	$(MAKE) all
