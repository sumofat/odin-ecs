package ecs

import "core:runtime"
import "core:container/queue"
import "core:mem"

ECS_Error :: enum {
  NO_ERROR,
  ENTITY_DOES_NOT_HAVE_THIS_COMPONENT,
  ENTITY_DOES_NOT_MAP_TO_ANY_INDEX,
  ENTITY_ALREADY_HAS_THIS_COMPONENT,
  COMPONENT_NOT_REGISTERED,
  COMPONENT_IS_ALREADY_REGISTERED,
}

Context :: struct {
  entities: Entities,
  component_map: map[typeid]Component_List,
}

ecs_arena : mem.Arena
ecs_allocator : mem.Allocator

init_ecs :: proc() -> (ctx: Context) {
	bytes,err := mem.alloc_bytes(1024*1024)
	mem.init_arena(&ecs_arena,bytes)

	ecs_allocator = mem.arena_allocator(&ecs_arena)
	context.allocator = ecs_allocator
  create_entities :: proc(ctx: ^Context) {
    ctx.entities.entities = make([dynamic]Entity)
    queue.init(&ctx.entities.available_slots,queue.DEFAULT_CAPACITY,ecs_allocator)
  }
  create_entities(&ctx)

  create_component_map :: proc(ctx: ^Context) {
    ctx.component_map = make(map[typeid]Component_List)
  }

  create_component_map(&ctx)

  return ctx
}

deinit_ecs :: proc(ctx: ^Context) {

  destroy_entities :: proc(ctx: ^Context) {
    delete(ctx.entities.entities)
    ctx.entities.current_entity_id = 0
    queue.destroy(&ctx.entities.available_slots)
  }
  destroy_entities(ctx)

  destroy_component_map :: proc(ctx: ^Context) {
    for key, value in ctx.component_map {
      queue.destroy(&(&ctx.component_map[key]).available_slots)
      free(value.data^.data)
      free(value.data)
    }
  
    for key, value in ctx.component_map {
      delete(value.entity_indices)
    }
  
    delete(ctx.component_map)
  }
  destroy_component_map(ctx)
}

