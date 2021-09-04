# Définition de variables qui seront réutilisées plus tard.
CC                 ?= gcc
CPPFLAGS           +=
CFLAGS             += -Wall -Wextra

# La première règle apparaissant dans le GNUMakefile est la règle par défaut
# lorsque le programme `make` est appelé sans arguments.
.PHONY: all
all: RunCmd Log710Shell Log710Shell2

.PHONY: clean
.SILENT: clean
clean:
	rm -f RunCmd
	rm -f Log710Shell
	rm -f Log710Shell2

# Indique comment construire la commande `RunCmd`.
RunCmd: RunCmd.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^

# Indique comment construire la commande `Log710Shell`.
Log710Shell: Log710Shell.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^

# Indique comment construire la commande `Log710Shell2`.
log710Shell2: Log710Shell2.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^
