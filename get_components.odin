package ecs

/* 
NOTE:
I know, code duplication...

There is no way to take in an array of types, and it will not be added to the language. 
The only reasonable solution is this...
*/

get_components_2 :: proc(entity: Entity, $A, $B: typeid) -> (^A, ^B, [2]ECS_Error) {
  a, err1 := get_component(entity, A)
  b, err2 := get_component(entity, B)
  return a, b, {}
}

get_components_3 :: proc(entity: Entity, $A, $B, $C: typeid) -> (^A, ^B, ^C, [3]ECS_Error) {
  a, err1 := get_component(entity, A)
  b, err2 := get_component(entity, B)
  c, err3 := get_component(entity, C)
  return a, b, c, {}
}

get_components_4 :: proc(entity: Entity, $A, $B, $C, $D: typeid) -> (^A, ^B, ^C, ^D, [4]ECS_Error) {
  a, err1 := get_component(entity, A)
  b, err2 := get_component(entity, B)
  c, err3 := get_component(entity, C)
  d, err4 := get_component(entity, D)
  return a, b, c, d, {}
}

get_components_5 :: proc(entity: Entity, $A, $B, $C, $D, $E: typeid) -> (^A, ^B, ^C, ^D, ^E, [5]ECS_Error) {
  a, err1 := get_component(entity, A)
  b, err2 := get_component(entity, B)
  c, err3 := get_component(entity, C)
  d, err4 := get_component(entity, D)
  e, err5 := get_component(entity, E)
  return a, b, c, d, e, {}
}

get_components :: proc {
  get_components_2, 
  get_components_3,
  get_components_4,
}
