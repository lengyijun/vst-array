Require Import VST.floyd.proofauto.
Require Import VST.floyd.library.
Require Import vst.mergesort.
Instance CompSpecs : compspecs. make_compspecs prog. Defined.
Definition Vprog : varspecs. mk_varspecs prog. Defined.

Require Export Coq.Lists.List.
Require Export Coq.Arith.Arith.
Require Import Program.Wf.

Definition my_mergesort_spec : ident * funspec :=
 DECLARE _my_mergesort
 WITH p: val,  sh : share, il: list Z, gv: globals
 PRE [ tptr tuint , tint ] 
    PROP (readable_share sh;
          3 < Zlength il <= Int.max_signed) 
    PARAMS (p; Vint (Int.repr (Zlength il - 1 )) )
    GLOBALS(gv) 
    SEP  (data_at sh (tarray tuint (Zlength il)) (map Vint (map Int.repr il)) p;
          mem_mgr gv)
 POST [ tvoid ] 
    PROP ( ) RETURN ()
    SEP (data_at sh (tarray tuint (Zlength il)) (map Vint (map Int.repr il)) p;
         mem_mgr gv).


Definition Gprog : funspecs :=
  ltac:(with_library prog [
             my_mergesort_spec                                    
 ]). 

Lemma body_my_mergesort: semax_body Vprog Gprog f_my_mergesort my_mergesort_spec.
Proof.
  start_function.

  assert_PROP (Zlength il = Zlength (map Vint (map Int.repr il))).
  entailer!.
  forward.
  entailer!.
Qed.
