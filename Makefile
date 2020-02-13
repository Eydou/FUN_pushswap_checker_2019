##
## EPITECH PROJECT, 2019
## Makefile
## File description:
## Makefile for clean.
##

SRC     =       main.hs

CC              =       ghc

NAME    =       pushswap_checker

FLAG    =       -W

all:    $(NAME)
$(NAME):
		$(CC) -o $(NAME) $(SRC) $(FLAG)
clean:
	rm -f $(shell find $(SOURCEDIR) -name '*.o')
	rm -f $(shell find $(SOURCEDIR) -name '*~')
	rm -f $(shell find $(SOURCEDIR) -name '*.hi')

fclean: clean
		rm -f $(NAME)

re:     fclean all

.PHONY: all clean fclean
