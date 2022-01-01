# Définition de variables qui seront réutilisées plus tard.
CC                 ?= gcc
CPPFLAGS           +=
CFLAGS             += -Wall -Wextra -Werror=vla -Werror=alloca -Werror=main -std=gnu11 -ggdb
LDFLAGS            +=

# En utilisant:
#
#     $ make clean all EYEBLEACH=1
#
# D'autres avertissements seront activés dans GCC.
ifdef EYEBLEACH
CFLAGS             += -Wpedantic
endif

# En utilisant:
#
#     $ make clean all IMPORTANT=1
#
# Certains avertissements seront convertit en erreurs, ce qui peut vous aider à
# trouver des problèmes dans votre code.
ifdef IMPORTANT
CFLAGS             += -Werror=uninitialized -Werror=format \
                      -Werror=implicit-function-declaration -Werror=format-overflow \
					  -Werror=misleading-indentation -Werror=return-type \
					  -Werror=maybe-uninitialized -Werror=conversion \
					  -Werror=sign-compare -Werror=address
endif

# Ne pas utiliser si vous ne savez pas ce que vous faites.
#
#     $ make clean all ASAN=1
#
# Active les outils *asan*, et *ubsan* de Google:
#     https://github.com/google/sanitizers
ifdef ASAN
CFLAGS             += -fsanitize=address -fsanitize=undefined
endif

# Ne pas utiliser si vous ne savez pas ce que vous faites.
#
#     $ make clean all LEAKSAN=1
#
# Active l'outil *leaksan* de Google:
#     https://github.com/google/sanitizers
ifdef LEAKSAN
LDFLAGS            += -fsanitize=leak
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
