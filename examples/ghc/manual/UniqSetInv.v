(* Default settings (from HsToCoq.Coq.Preamble) *)

Generalizable All Variables.

Unset Implicit Arguments.
Set Maximal Implicit Insertion.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

Require Coq.Program.Tactics.
Require Coq.Program.Wf.

(* Converted imports: *)

Require Data.Foldable.
Require GHC.Base.
Require GHC.Prim.
Require UniqFM.
Require Unique.
Import GHC.Base.Notations.
Import GHC.Base.ManualNotations.

Import Unique.
Import UniqFM.

(* Converted type declarations: *)


(** The invariant is that for any value contained in the set, if we lookup that value by its Unique


*)
Polymorphic Definition UniqInv@{i} {a:Type@{i}} (fm : UniqFM.UniqFM a) `{Unique.Uniquable a} : Type@{i} :=
  forall (x:a)(y:a), 
    UniqFM.lookupUFM fm (getUnique x) = Some y -> getUnique x = getUnique y. 


Polymorphic Definition UniqSet@{i} (a:Type@{i}) `{Unique.Uniquable a} : Type@{i} :=
  sigT (fun fm => UniqInv fm).

Definition Mk_UniqSet := existT.

Arguments Mk_UniqSet {_} {_} _.

Definition getUniqSet' {a}`{Uniquable a} (arg_0__ : UniqSet a) :=
  let 'existT getUniqSet' _ := arg_0__ in
  getUniqSet'.

(* Converted value declarations: *)

(* SCW we DON'T want to coerce *)
(*
Instance Unpeel_UniqSet ele
   : GHC.Prim.Unpeel (UniqSet ele) (UniqFM.UniqFM ele) :=
  GHC.Prim.Build_Unpeel _ _ (fun '(Mk_UniqSet y) => y) Mk_UniqSet.
*)

(* Skipping instance Eq___UniqSet *)

(* Skipping instance Outputable__UniqSet of class Outputable *)

Program Definition Monoid__UniqSet_mempty {inst_a} `{Unique.Uniquable inst_a} : 
  UniqSet inst_a :=
  Mk_UniqSet GHC.Base.mempty _.
(*
Next Obligation.
unfold UniqInv.
intros. simpl in *. contradiction.
Qed. *)

(*
Local Definition Monoid__UniqSet_mconcat {inst_a}
   : list (UniqSet inst_a) -> UniqSet inst_a :=
  GHC.Prim.coerce GHC.Base.mconcat.

Local Definition Monoid__UniqSet_mappend {inst_a}
   : UniqSet inst_a -> UniqSet inst_a -> UniqSet inst_a :=
  GHC.Prim.coerce GHC.Base.mappend.

Local Definition Semigroup__UniqSet_op_zlzlzgzg__ {inst_a}
   : UniqSet inst_a -> UniqSet inst_a -> UniqSet inst_a :=
  GHC.Prim.coerce _GHC.Base.<<>>_.

Program Instance Semigroup__UniqSet {a} : GHC.Base.Semigroup (UniqSet a) :=
  fun _ k => k {| GHC.Base.op_zlzlzgzg____ := Semigroup__UniqSet_op_zlzlzgzg__ |}.

Program Instance Monoid__UniqSet {a} : GHC.Base.Monoid (UniqSet a) :=
  fun _ k =>
    k {| GHC.Base.mappend__ := Monoid__UniqSet_mappend ;
         GHC.Base.mconcat__ := Monoid__UniqSet_mconcat ;
         GHC.Base.mempty__ := Monoid__UniqSet_mempty |}.
*)
(* Skipping instance Data__UniqSet of class Data *)

Definition eqUnique_eq : forall u1 u2, eqUnique u1 u2 = true <-> u1 = u2.
Proof.
  intros.
  unfold eqUnique.
  destruct u1; destruct u2.
  unfold GHC.Base.op_zeze__.
  unfold Base.Eq_Char___.
  unfold Base.op_zeze____.
  rewrite BinNat.N.eqb_eq. 
  split. intros h; rewrite h; auto.
  intros h; inversion h; auto.
Qed.

Definition eqUnique_neq : forall u1 u2, eqUnique u1 u2 = false <-> u1 <> u2.
Proof.
  intros.
  unfold eqUnique.
  destruct u1; destruct u2.
  unfold GHC.Base.op_zeze__.
  unfold Base.Eq_Char___.
  unfold Base.op_zeze____.
  rewrite BinNat.N.eqb_neq. 
  split. unfold not. intros m h; inversion h; auto.
  unfold not. intros m h; rewrite h in m; auto.
Qed.

Axiom lookup_insert : 
  forall b key (val:b) m, Internal.lookup key (Internal.insert key val m) = Some val.
Axiom lookup_insert_neq : 
  forall b key1 key2 (val:b) m, 
    key1 <> key2 ->
    Internal.lookup key1 (Internal.insert key2 val m) = Internal.lookup key1 m.

Lemma getUnique_idempotent : forall a `{Uniquable a} (x:a), getUnique(getUnique x) = getUnique x. 
Proof.
  intros.
  unfold getUnique.
  unfold Uniquable__Unique.
  unfold getUnique__.
  unfold Unique.Uniquable__Unique_getUnique.
  auto.
Qed.

Program Definition addOneToUniqSet {a} `{Unique.Uniquable a}
   : UniqSet a -> a -> UniqSet a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT set _, x => Mk_UniqSet (UniqFM.addToUFM set x x) _
    end.
Next Obligation.
unfold UniqInv in *.
unfold UniqFM.addToUFM.
unfold UniqFM.lookupUFM in *.
intros.
destruct set.
rename arg_1__ into z.
rewrite getUnique_idempotent in *.
destruct (eqUnique (getUnique z) (getUnique x)) eqn:EQ.
- apply eqUnique_eq in EQ. rewrite <- EQ in *.
  rewrite lookup_insert in H0.
  inversion H0.
  auto.
- apply eqUnique_neq in EQ.
  rewrite lookup_insert_neq in H0.
  apply wildcard'.
  rewrite getUnique_idempotent. auto.
  unfold getWordKey.
  unfold getKey.
  unfold not in *.
  intro h.
  apply EQ.
  destruct (getUnique x).
  destruct (getUnique z).
  subst.
  auto.
Defined.

Definition addListToUniqSet {a} `{Unique.Uniquable a}
   : UniqSet a -> list a -> UniqSet a :=
  Data.Foldable.foldl' addOneToUniqSet.

Program Definition delListFromUniqSet {a} `{Unique.Uniquable a}
   : UniqSet a -> list a -> UniqSet a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT s _, l => Mk_UniqSet (UniqFM.delListFromUFM s l) _
    end.
Next Obligation.
Admitted.
 
Program Definition delListFromUniqSet_Directly {a} `{Unique.Uniquable a}
   : UniqSet a -> list Unique.Unique -> UniqSet a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT s _, l => Mk_UniqSet (UniqFM.delListFromUFM_Directly s l) _
    end.
Next Obligation.
Admitted.

Program Definition delOneFromUniqSet {a} `{Unique.Uniquable a}
   : UniqSet a -> a -> UniqSet a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT s _, a => Mk_UniqSet (UniqFM.delFromUFM s a) _
    end.
Next Obligation.
Admitted.

Program Definition delOneFromUniqSet_Directly {a} `{Unique.Uniquable a}
   : UniqSet a -> Unique.Unique -> UniqSet a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT s _, u => Mk_UniqSet (UniqFM.delFromUFM_Directly s u) _
    end.
Next Obligation.
Admitted.

Definition elemUniqSet_Directly {a} `{Unique.Uniquable a} : Unique.Unique -> UniqSet a -> bool :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | a, existT s _ => UniqFM.elemUFM_Directly a s 
    end.

Definition elementOfUniqSet {a} `{Unique.Uniquable a}
   : a -> UniqSet a -> bool :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | a, existT s _ => UniqFM.elemUFM a s
    end.

Program Definition emptyUniqSet {a} `{Unique.Uniquable a}: UniqSet a :=
  Mk_UniqSet UniqFM.emptyUFM _.

Definition mkUniqSet {a} `{Unique.Uniquable a} : list a -> UniqSet a :=
  Data.Foldable.foldl' addOneToUniqSet emptyUniqSet.

Program Definition filterUniqSet {a} `{Unique.Uniquable a} : (a -> bool) -> UniqSet a -> UniqSet a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | p, existT s _ => Mk_UniqSet (UniqFM.filterUFM p s) _
    end.
Next Obligation.
Admitted.

Program Definition filterUniqSet_Directly {elt} `{Unique.Uniquable elt}
   : (Unique.Unique -> elt -> bool) -> UniqSet elt -> UniqSet elt :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | f, existT s _ => Mk_UniqSet (UniqFM.filterUFM_Directly f s) _
    end.
Next Obligation.
Admitted.

Definition getUniqSet {a} `{Unique.Uniquable a} : UniqSet a -> UniqFM.UniqFM a :=
  getUniqSet'.

Program Definition intersectUniqSets {a} `{Unique.Uniquable a} : UniqSet a -> UniqSet a -> UniqSet a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT s _, existT t _ => Mk_UniqSet (UniqFM.intersectUFM s t) _
    end.
Next Obligation.
Admitted.

Definition isEmptyUniqSet {a} `{Unique.Uniquable a} : UniqSet a -> bool :=
  fun '(existT s _) => UniqFM.isNullUFM s.

Definition lookupUniqSet {a} {b} `{Unique.Uniquable a} `{Unique.Uniquable b}
   : UniqSet b -> a -> option b :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT s _, k => UniqFM.lookupUFM s k
    end.

Definition lookupUniqSet_Directly {a} `{Unique.Uniquable a}
   : UniqSet a -> Unique.Unique -> option a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT s _, k => UniqFM.lookupUFM_Directly s k
    end.

Program Definition minusUniqSet {a} `{Unique.Uniquable a} : UniqSet a -> UniqSet a -> UniqSet a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT s _, existT t _ => Mk_UniqSet (UniqFM.minusUFM s t) _
    end.
Next Obligation.
Admitted.

Definition nonDetEltsUniqSet {elt} `{Unique.Uniquable elt} : UniqSet elt -> list elt :=
  UniqFM.nonDetEltsUFM GHC.Base.∘ getUniqSet'.

Definition mapUniqSet {b} {a} `{Unique.Uniquable a} `{Unique.Uniquable b}
   : (a -> b) -> UniqSet a -> UniqSet b :=
  fun f => mkUniqSet GHC.Base.∘ (GHC.Base.map f GHC.Base.∘ nonDetEltsUniqSet).

Definition nonDetFoldUniqSet {elt} {a} `{Unique.Uniquable elt}
   : (elt -> a -> a) -> a -> UniqSet elt -> a :=
  fun arg_0__ arg_1__ arg_2__ =>
    match arg_0__, arg_1__, arg_2__ with
    | c, n, existT s _ => UniqFM.nonDetFoldUFM c n s
    end.

Definition nonDetFoldUniqSet_Directly {elt} {a} `{Unique.Uniquable elt} `{Unique.Uniquable a}
   : (Unique.Unique -> elt -> a -> a) -> a -> UniqSet elt -> a :=
  fun arg_0__ arg_1__ arg_2__ =>
    match arg_0__, arg_1__, arg_2__ with
    | f, n, existT s _ => UniqFM.nonDetFoldUFM_Directly f n s
    end.

Definition nonDetKeysUniqSet {elt} `{Unique.Uniquable elt} : UniqSet elt -> list Unique.Unique :=
  UniqFM.nonDetKeysUFM GHC.Base.∘ getUniqSet'.

Program Definition partitionUniqSet {a} `{Unique.Uniquable a}
   : (a -> bool) -> UniqSet a -> (UniqSet a * UniqSet a)%type :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | p, existT s _ => let '(x,y):= (UniqFM.partitionUFM p s) in (existT _ x _, existT _ y _)
    end.
Next Obligation.
Admitted.
Next Obligation.
Admitted.

Program Definition restrictUniqSetToUFM {a} {b} `{Unique.Uniquable a} `{Unique.Uniquable b}
   : UniqSet a -> UniqFM.UniqFM b -> UniqSet a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT s _, m => Mk_UniqSet (UniqFM.intersectUFM s m) _
    end.
Next Obligation.
Admitted.

Definition sizeUniqSet {a} `{Unique.Uniquable a} : UniqSet a -> nat :=
  fun '(existT s _) => UniqFM.sizeUFM s.

Program Definition unionUniqSets {a} `{Unique.Uniquable a} : UniqSet a -> UniqSet a -> UniqSet a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT s _, existT t _ => Mk_UniqSet (UniqFM.plusUFM s t) _
    end.
Next Obligation.
Admitted.

Definition unionManyUniqSets {a} `{Unique.Uniquable a} (xs : list (UniqSet a)) : UniqSet a :=
  match xs with
  | nil => emptyUniqSet
  | cons set sets => Data.Foldable.foldr unionUniqSets set sets
  end.

Definition uniqSetAll {a} `{Unique.Uniquable a} : (a -> bool) -> UniqSet a -> bool :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | p, existT s _ => UniqFM.allUFM p s
    end.

Definition uniqSetAny {a} `{Unique.Uniquable a} : (a -> bool) -> UniqSet a -> bool :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | p, existT s _ => UniqFM.anyUFM p s
    end.

Program Definition uniqSetMinusUFM {a} {b} `{Unique.Uniquable a} `{Unique.Uniquable b}
   : UniqSet a -> UniqFM.UniqFM b -> UniqSet a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | existT s _, t => Mk_UniqSet (UniqFM.minusUFM s t) _
    end.
Next Obligation.
Admitted.

Program Definition unitUniqSet {a} `{Unique.Uniquable a} : a -> UniqSet a :=
  fun x => Mk_UniqSet (UniqFM.unitUFM x x) _.
Next Obligation.
Admitted.

(* Definition unsafeUFMToUniqSet {a} : UniqFM.UniqFM a -> UniqSet a :=
  Mk_UniqSet. *)

(* External variables:
     bool cons list nat op_zt__ option Data.Foldable.foldl' Data.Foldable.foldr
     GHC.Base.Monoid GHC.Base.Semigroup GHC.Base.map GHC.Base.mappend
     GHC.Base.mappend__ GHC.Base.mconcat GHC.Base.mconcat__ GHC.Base.mempty
     GHC.Base.mempty__ GHC.Base.op_z2218U__ GHC.Base.op_zlzlzgzg__
     GHC.Base.op_zlzlzgzg____ GHC.Prim.Build_Unpeel GHC.Prim.Unpeel GHC.Prim.coerce
     UniqFM.UniqFM UniqFM.addToUFM UniqFM.allUFM UniqFM.anyUFM UniqFM.delFromUFM
     UniqFM.delFromUFM_Directly UniqFM.delListFromUFM UniqFM.delListFromUFM_Directly
     UniqFM.elemUFM UniqFM.elemUFM_Directly UniqFM.emptyUFM UniqFM.filterUFM
     UniqFM.filterUFM_Directly UniqFM.intersectUFM UniqFM.isNullUFM UniqFM.lookupUFM
     UniqFM.lookupUFM_Directly UniqFM.minusUFM UniqFM.nonDetEltsUFM
     UniqFM.nonDetFoldUFM UniqFM.nonDetFoldUFM_Directly UniqFM.nonDetKeysUFM
     UniqFM.partitionUFM UniqFM.plusUFM UniqFM.sizeUFM UniqFM.unitUFM
     Unique.Uniquable Unique.Unique
*)