#include <assert.h>
#include <signal.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "test.h"

void register_server(struct bus_t** bus, struct handler_t* topic_handler)
{
	struct bus_t *p = malloc(sizeof(struct bus_t));
	p->address = topic_handler->topic_name;
	p->address_handler = topic_handler->topic_handler;
	p->type = topic_handler->topic_type;
	*bus = p;
}

void loop(struct bus_t* bus)
{
	while (1) {
		printf("bus: %p; handler: %p; address: %s\n", bus, bus->address_handler, bus->address);
		bus->address_handler();
	}
}

