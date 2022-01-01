# Définition de variables qui seront réutilisées plus tard.
CC                 ?= gcc
CPPFLAGS           +=
CFLAGS             += -Wall -Wextra -Werror=vla -std=gnu11 -ggdb
LDFLAGS            +=

# En utilisant:
#
#     $ make clean all EYEBLEACH=1
#
# D'autres avertissements seront activés dans GCC.
ifdef EYEBLEACH
CFLAGS             += -Wpedantic
endif

# Ne pas utiliser si vous ne savez pas ce que vous faites.
#
#     $ make clean all ASAN=1
#
# Active l'outil AddressSanitizer de Google:
#     https://github.com/google/sanitizers
ifdef ASAN
CFLAGS             += -fsanitize=address
LDFLAGS            += -fsanitize=address
endif

# La première règle apparaissant dans le GNUMakefile est la règle par défaut
# lorsque le programme `make` est appelé sans arguments.
.PHONY: all
all: RunCmd Log710Shell Log710Shell2

# Une règle pour nétoyer le projet et supprimer les exécutables générés.
#
# Il est possible de faire une recompilation de tous les artéfacts avec la
# commande suivante:
#
#     $ make clean all
.PHONY: clean
.SILENT: clean
clean:
	rm -f RunCmd
	rm -f Log710Shell
	rm -f Log710Shell2

# Indique comment construire la commande `RunCmd`.
RunCmd: RunCmd.c
	$(CC) $(LDFLAGS) $(CPPFLAGS) $(CFLAGS) -o $@ $^

# Indique comment construire la commande `Log710Shell`.
Log710Shell: Log710Shell.c
	$(CC) $(LDFLAGS) $(CPPFLAGS) $(CFLAGS) -o $@ $^

# Indique comment construire la commande `Log710Shell2`.
log710Shell2: Log710Shell2.c
	$(CC) $(LDFLAGS) $(CPPFLAGS) $(CFLAGS) -o $@ $^
