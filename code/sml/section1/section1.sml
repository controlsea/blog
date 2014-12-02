(* This is a comment. This is our first program. *)

val x = 34; 

(* static enviroment: x : int *)
(* dynamic enviroment: x --> 34 *)

val y = 17;

(* static enviroment: x:int, y:int *)
(* dynamic enviroment: x --> 34, y --> 17 *)

val z = (x+y) + (y+2)

(* static enviroment: x:int, y:int, z:int *)
(* dynamic enviroment: x--> 34, y-->17, z --> 70 *)

val q = z+1

(* static enviroment: x:int, y:int, z:int, q:int *)
(* dynamic enviroment: x--> 34, y-->17, z --> 71 *)


val abs_of_z = if z<0 then 0-z else z;(*bool*)(*int*)

(* dynamic enviroment: ..., abs_if_z --> 70 *)

val abs_of_z_simpler = abs(z)

val a = 10
(* a:int a -> 10 *)

val b = a*2
(* b -> 20 *)

val a = 5 (*  this is not an assignment statement *)
(*There is  no way in ML to mutate or change the fact that a = 10 in previous enviroment all we get is a subsequence enviroment,a is shadowed, we have a different mapping for a in a different envrioment*)
(* a -> 5, b-> 20 *)

val c = b
(* a -> 5, b -> 20 , c -> 20  *)

val d = a
(* ...,in the current envrioment a -> 5, d->5 *)

val a = a + 1
(*create a new envrioment, a -> 6*)

(*Note:correct only if y>=0 *)

fun pow(x:int, y:int) = if y=0 then 1 else x*pow(x,y-1)

fun cube(x:int) = pow(x,3)

fun swap(pr :int * bool) = (#2 pr, #1 pr)

(* (int*int) * (int*int) -> int *) 
fun sum_two_pairs (pr1 : int * int, pr2 : int * int) = (#1 pr1)+(#2 pr1)+(#1 pr2)+ (#2 pr2)
(* int*int -> int *int *)
fun div_mod (x:int,y:int) = (x div y , x mod y)

fun sort_pair(pr:int*int) = 
    if (#1 pr) < (#2 pr)
    then pr 
    else (#2 pr, #1 pr)

