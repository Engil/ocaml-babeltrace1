module Bt = Babeltrace1

open Rresult.R.Infix

let create_context () = Bt.create_context () >>= fun _ -> Ok ()

let add_trace () =
  Bt.create_context ()
  >>= fun ctx ->
  Bt.add_trace ctx `Ctf "assets/"
  >>= fun id ->
  Printf.printf "1\n";
  let iter = Bt.Ctf.create_iter ctx in
  Printf.printf "1\n";
  let ev = Bt.Ctf.read_event iter in
  Printf.printf "1\n";
  (match Bt.Ctf.Events.get_name ev with Some s -> Error (`Msg s) | None -> Ok ())
  >>= fun () ->
  Bt.remove_trace ctx id
  >>= fun () ->
  Ok ()

let tests = [
  "create_context", create_context;
  "add_trace", add_trace;
]
