open Ctypes
open Foreign
open Unsigned.Size_t

let bus_handler = void @-> returning void
let fptr_buf_handler = funptr bus_handler

type handler_t
let handler_t: handler_t structure typ = structure "handler_t"

let topic_name = field handler_t "topic_name" (ptr char)
let topic_handler = field handler_t "topic_handler" fptr_buf_handler
let topic_type = field handler_t "topic_type" int
let () = seal handler_t

let loop = foreign "loop" (ptr void @-> returning void)
let register_server = foreign "register_server" (ptr (ptr void) @-> ptr handler_t @-> returning void)

let char_null = coerce (ptr void) (ptr char) null
let bus_ptr = allocate (ptr void) null

let sname = 
        let v = CArray.of_list char ['s';'e';'r';'v';'e';'r'] in
        CArray.start v

let handler = make handler_t

let server_handler () =
        Printf.printf "got request\n%!"

let floop address haddr =
        register_server bus_ptr haddr;
        loop (!@ bus_ptr)

let todo () =
        let haddr = addr handler in (
                Printf.printf "haddr: %nx\n%!" (to_voidp haddr |> raw_address_of_ptr);
                setf handler topic_name sname;
                setf handler topic_handler server_handler;
                setf handler topic_type 0;
                floop sname (addr handler)
        )


let () = todo ()
