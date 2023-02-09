#include "ft.h"

#include <stdio.h>

t_err	ft_puts(const char *str)
{
	return (puts(str) == EOF);
}
