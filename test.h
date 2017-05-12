#ifndef BUS_H
#define BUS_H

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

typedef void bus_handler();

struct bus_t {
	char *address;
	bus_handler *address_handler;
	int type;
};

struct handler_t {
	char *topic_name;
	bus_handler *topic_handler;
	int topic_type;
};

void register_server(struct bus_t **bus, struct handler_t *topic_handler);
void loop(struct bus_t *bus);

#endif // BUS_H
