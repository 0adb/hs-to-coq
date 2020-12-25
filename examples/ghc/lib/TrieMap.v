(* Default settings (from HsToCoq.Coq.Preamble) *)

Generalizable All Variables.

Unset Implicit Arguments.
Set Maximal Implicit Insertion.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

Require Coq.Program.Tactics.
Require Coq.Program.Wf.

(* Converted imports: *)

Require AxiomatizedTypes.
Require Core.
Require Data.Foldable.
Require Data.IntSet.Internal.
Require Data.Map.Internal.
Require FastString.
Require GHC.Base.
Require GHC.Num.
Require HsToCoq.Err.
Require IntMap.
Require Literal.
Require Name.
Require NameEnv.
Require UniqFM.
Require Unique.
Import GHC.Base.Notations.
Import GHC.Num.Notations.

(* Converted type declarations: *)

Definition XT a :=
  (option a -> option a)%type.

Axiom TypeMapX : forall (a : Type), Type.

Inductive TyLitMap a : Type :=
  | TLM (tlm_number : Data.Map.Internal.Map GHC.Num.Integer a) (tlm_string
    : Data.Map.Internal.Map FastString.FastString a)
   : TyLitMap a.

Class TrieMap (m : Type -> Type) := {
  Key : Type ;
  alterTM : forall {b : Type}, Key -> XT b -> m b -> m b ;
  emptyTM : forall {a : Type}, m a ;
  foldTM : forall {a : Type}, forall {b : Type}, (a -> b -> b) -> m a -> b -> b ;
  lookupTM : forall {b : Type}, Key -> m b -> option b ;
  mapTM : forall {a : Type}, forall {b : Type}, (a -> b) -> m a -> m b }.

Arguments Key _ {_}.

Definition TickishMap :=
  (Data.Map.Internal.Map (Core.Tickish Core.Id))%type.

Inductive MaybeMap m a : Type :=
  | MM (mm_nothing : option a) (mm_just : m a) : MaybeMap m a.

Definition LiteralMap :=
  (Data.Map.Internal.Map Literal.Literal)%type.

Axiom ListMap : forall (m : Type -> Type) (a : Type), Type.

Axiom GenMap : forall (m : Type -> Type) (a : Type), Type.

Definition TypeMapG :=
  (GenMap TypeMapX)%type.

Inductive LooseTypeMap a : Type :=
  | Mk_LooseTypeMap : (TypeMapG a) -> LooseTypeMap a.

Inductive TypeMap a : Type :=
  | Mk_TypeMap : (TypeMapG (TypeMapG a)) -> TypeMap a.

Axiom CoreMapX : forall (a : Type), Type.

Definition CoreMapG :=
  (GenMap CoreMapX)%type.

Inductive CoreMap a : Type := | Mk_CoreMap : (CoreMapG a) -> CoreMap a.

Inductive CoercionMapX a : Type :=
  | Mk_CoercionMapX : (TypeMapX a) -> CoercionMapX a.

Definition CoercionMapG :=
  (GenMap CoercionMapX)%type.

Inductive CoercionMap a : Type :=
  | Mk_CoercionMap : (CoercionMapG a) -> CoercionMap a.

Definition BoundVarMap :=
  IntMap.IntMap%type.

Inductive VarMap a : Type :=
  | VM (vm_bvar : BoundVarMap a) (vm_fvar : Core.DVarEnv a) : VarMap a.

Definition BoundVar :=
  Data.IntSet.Internal.Key%type.

Inductive CmEnv : Type :=
  | CME (cme_next : BoundVar) (cme_env : Core.VarEnv BoundVar) : CmEnv.

Inductive DeBruijn a : Type := | D : CmEnv -> a -> DeBruijn a.

Definition BndrMap :=
  TypeMapG%type.

Inductive AltMap a : Type :=
  | AM (am_deflt : CoreMapG a) (am_data : NameEnv.DNameEnv (CoreMapG a)) (am_lit
    : LiteralMap (CoreMapG a))
   : AltMap a.

Arguments TLM {_} _ _.

Arguments MM {_} {_} _ _.

Arguments Mk_LooseTypeMap {_} _.

Arguments Mk_TypeMap {_} _.

Arguments Mk_CoreMap {_} _.

Arguments Mk_CoercionMapX {_} _.

Arguments Mk_CoercionMap {_} _.

Arguments VM {_} _ _.

Arguments D {_} _ _.

Arguments AM {_} _ _ _.

Instance Default__CmEnv : HsToCoq.Err.Default CmEnv :=
  HsToCoq.Err.Build_Default _ (CME HsToCoq.Err.default HsToCoq.Err.default).

Definition tlm_number {a} (arg_0__ : TyLitMap a) :=
  let 'TLM tlm_number _ := arg_0__ in
  tlm_number.

Definition tlm_string {a} (arg_0__ : TyLitMap a) :=
  let 'TLM _ tlm_string := arg_0__ in
  tlm_string.

Definition mm_just {m} {a} (arg_0__ : MaybeMap m a) :=
  let 'MM _ mm_just := arg_0__ in
  mm_just.

Definition mm_nothing {m} {a} (arg_0__ : MaybeMap m a) :=
  let 'MM mm_nothing _ := arg_0__ in
  mm_nothing.

Definition vm_bvar {a} (arg_0__ : VarMap a) :=
  let 'VM vm_bvar _ := arg_0__ in
  vm_bvar.

Definition vm_fvar {a} (arg_0__ : VarMap a) :=
  let 'VM _ vm_fvar := arg_0__ in
  vm_fvar.

Definition cme_env (arg_0__ : CmEnv) :=
  let 'CME _ cme_env := arg_0__ in
  cme_env.

Definition cme_next (arg_0__ : CmEnv) :=
  let 'CME cme_next _ := arg_0__ in
  cme_next.

Definition am_data {a} (arg_0__ : AltMap a) :=
  let 'AM _ am_data _ := arg_0__ in
  am_data.

Definition am_deflt {a} (arg_0__ : AltMap a) :=
  let 'AM am_deflt _ _ := arg_0__ in
  am_deflt.

Definition am_lit {a} (arg_0__ : AltMap a) :=
  let 'AM _ _ am_lit := arg_0__ in
  am_lit.

(* Midamble *)

Instance Eq___DeBruijn__unit : GHC.Base.Eq_ (DeBruijn unit).
Proof.
Admitted.

(* Converted value declarations: *)

Local Definition TrieMap__IntMap_Key : Type :=
  Data.IntSet.Internal.Key.

Definition xtInt {a}
   : Data.IntSet.Internal.Key -> XT a -> IntMap.IntMap a -> IntMap.IntMap a :=
  fun k f m => IntMap.alter f k m.

Local Definition TrieMap__IntMap_alterTM
   : forall {b : Type},
     TrieMap__IntMap_Key -> XT b -> IntMap.IntMap b -> IntMap.IntMap b :=
  fun {b : Type} => xtInt.

Local Definition TrieMap__IntMap_emptyTM : forall {a : Type}, IntMap.IntMap a :=
  fun {a : Type} => IntMap.empty.

Local Definition TrieMap__IntMap_foldTM
   : forall {a : Type},
     forall {b : Type}, (a -> b -> b) -> IntMap.IntMap a -> b -> b :=
  fun {a : Type} {b : Type} => fun k m z => IntMap.foldr k z m.

Local Definition TrieMap__IntMap_lookupTM
   : forall {b : Type}, TrieMap__IntMap_Key -> IntMap.IntMap b -> option b :=
  fun {b : Type} => fun k m => IntMap.lookup k m.

Local Definition TrieMap__IntMap_mapTM
   : forall {a : Type},
     forall {b : Type}, (a -> b) -> IntMap.IntMap a -> IntMap.IntMap b :=
  fun {a : Type} {b : Type} => fun f m => IntMap.map f m.

Program Instance TrieMap__IntMap : TrieMap IntMap.IntMap :=
  {
  Key := TrieMap__IntMap_Key ;
  alterTM := fun {b : Type} => TrieMap__IntMap_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__IntMap_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__IntMap_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__IntMap_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__IntMap_mapTM }.

Local Definition TrieMap__Map_Key {k : Type} `{GHC.Base.Ord k} : Type :=
  k.

Local Definition TrieMap__Map_alterTM {inst_k : Type} `{GHC.Base.Ord inst_k}
   : forall {b : Type},
     TrieMap__Map_Key ->
     XT b -> Data.Map.Internal.Map inst_k b -> Data.Map.Internal.Map inst_k b :=
  fun {b : Type} => fun k f m => Data.Map.Internal.alter f k m.

Local Definition TrieMap__Map_emptyTM {inst_k : Type} `{GHC.Base.Ord inst_k}
   : forall {a : Type}, Data.Map.Internal.Map inst_k a :=
  fun {a : Type} => Data.Map.Internal.empty.

Local Definition TrieMap__Map_foldTM {inst_k : Type} `{GHC.Base.Ord inst_k}
   : forall {a : Type},
     forall {b : Type}, (a -> b -> b) -> Data.Map.Internal.Map inst_k a -> b -> b :=
  fun {a : Type} {b : Type} => fun k m z => Data.Map.Internal.foldr k z m.

Local Definition TrieMap__Map_lookupTM {inst_k : Type} `{GHC.Base.Ord inst_k}
   : forall {b : Type},
     TrieMap__Map_Key -> Data.Map.Internal.Map inst_k b -> option b :=
  fun {b : Type} => Data.Map.Internal.lookup.

Local Definition TrieMap__Map_mapTM {inst_k : Type} `{GHC.Base.Ord inst_k}
   : forall {a : Type},
     forall {b : Type},
     (a -> b) -> Data.Map.Internal.Map inst_k a -> Data.Map.Internal.Map inst_k b :=
  fun {a : Type} {b : Type} => fun f m => Data.Map.Internal.map f m.

Program Instance TrieMap__Map {k : Type} `{GHC.Base.Ord k}
   : TrieMap (Data.Map.Internal.Map k) :=
  {
  Key := TrieMap__Map_Key ;
  alterTM := fun {b : Type} => TrieMap__Map_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__Map_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__Map_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__Map_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__Map_mapTM }.

Local Definition TrieMap__UniqFM_Key : Type :=
  Unique.Unique.

Local Definition TrieMap__UniqFM_alterTM
   : forall {b : Type},
     TrieMap__UniqFM_Key -> XT b -> UniqFM.UniqFM b -> UniqFM.UniqFM b :=
  fun {b : Type} => fun k f m => UniqFM.alterUFM f m k.

Local Definition TrieMap__UniqFM_emptyTM : forall {a : Type}, UniqFM.UniqFM a :=
  fun {a : Type} => UniqFM.emptyUFM.

Local Definition TrieMap__UniqFM_foldTM
   : forall {a : Type},
     forall {b : Type}, (a -> b -> b) -> UniqFM.UniqFM a -> b -> b :=
  fun {a : Type} {b : Type} => fun k m z => UniqFM.nonDetFoldUFM k z m.

Local Definition TrieMap__UniqFM_lookupTM
   : forall {b : Type}, TrieMap__UniqFM_Key -> UniqFM.UniqFM b -> option b :=
  fun {b : Type} => fun k m => UniqFM.lookupUFM m k.

Local Definition TrieMap__UniqFM_mapTM
   : forall {a : Type},
     forall {b : Type}, (a -> b) -> UniqFM.UniqFM a -> UniqFM.UniqFM b :=
  fun {a : Type} {b : Type} => fun f m => UniqFM.mapUFM f m.

Program Instance TrieMap__UniqFM : TrieMap UniqFM.UniqFM :=
  {
  Key := TrieMap__UniqFM_Key ;
  alterTM := fun {b : Type} => TrieMap__UniqFM_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__UniqFM_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__UniqFM_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__UniqFM_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__UniqFM_mapTM }.

Local Definition TrieMap__MaybeMap_Key {m : Type -> Type} `{TrieMap m} : Type :=
  option (Key m).

Definition op_zbzg__ {a : Type} {b : Type} : a -> (a -> b) -> b :=
  fun x f => f x.

Notation "'_|>_'" := (op_zbzg__).

Infix "|>" := (_|>_) (at level 99).

Definition xtMaybe {k} {m} {a}
   : (forall {b}, k -> XT b -> m b -> m b) ->
     option k -> XT a -> MaybeMap m a -> MaybeMap m a :=
  fun arg_0__ arg_1__ arg_2__ arg_3__ =>
    match arg_0__, arg_1__, arg_2__, arg_3__ with
    | _, None, f, m =>
        let 'MM mm_nothing_4__ mm_just_5__ := m in
        MM (f (mm_nothing m)) mm_just_5__
    | tr, Some x, f, m =>
        let 'MM mm_nothing_9__ mm_just_10__ := m in
        MM mm_nothing_9__ (mm_just m |> tr _ x f)
    end.

Local Definition TrieMap__MaybeMap_alterTM {inst_m : Type -> Type} `{TrieMap
  inst_m}
   : forall {b : Type},
     TrieMap__MaybeMap_Key -> XT b -> MaybeMap inst_m b -> MaybeMap inst_m b :=
  fun {b : Type} => xtMaybe (fun {b} => alterTM).

Local Definition TrieMap__MaybeMap_emptyTM {inst_m : Type -> Type} `{TrieMap
  inst_m}
   : forall {a : Type}, MaybeMap inst_m a :=
  fun {a : Type} => MM None emptyTM.

Definition foldMaybe {a} {b} : (a -> b -> b) -> option a -> b -> b :=
  fun arg_0__ arg_1__ arg_2__ =>
    match arg_0__, arg_1__, arg_2__ with
    | _, None, b => b
    | k, Some a, b => k a b
    end.

Definition fdMaybe {m} {a} {b} `{TrieMap m}
   : (a -> b -> b) -> MaybeMap m a -> b -> b :=
  fun k m => foldMaybe k (mm_nothing m) GHC.Base.∘ foldTM k (mm_just m).

Local Definition TrieMap__MaybeMap_foldTM {inst_m : Type -> Type} `{TrieMap
  inst_m}
   : forall {a : Type},
     forall {b : Type}, (a -> b -> b) -> MaybeMap inst_m a -> b -> b :=
  fun {a : Type} {b : Type} => fdMaybe.

Definition op_zgzizg__ {a : Type} {b : Type} {c : Type}
   : (a -> b) -> (b -> c) -> a -> c :=
  fun f g x => g (f x).

Notation "'_>.>_'" := (op_zgzizg__).

Infix ">.>" := (_>.>_) (at level 99).

Definition lkMaybe {k} {m} {a}
   : (forall {b}, k -> m b -> option b) -> option k -> MaybeMap m a -> option a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | _, None => mm_nothing
    | lk, Some x => mm_just >.> lk _ x
    end.

Local Definition TrieMap__MaybeMap_lookupTM {inst_m : Type -> Type} `{TrieMap
  inst_m}
   : forall {b : Type}, TrieMap__MaybeMap_Key -> MaybeMap inst_m b -> option b :=
  fun {b : Type} => lkMaybe (fun {b} => lookupTM).

Definition mapMb {m} {a} {b} `{TrieMap m}
   : (a -> b) -> MaybeMap m a -> MaybeMap m b :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | f, MM mn mj => MM (GHC.Base.fmap f mn) (mapTM f mj)
    end.

Local Definition TrieMap__MaybeMap_mapTM {inst_m : Type -> Type} `{TrieMap
  inst_m}
   : forall {a : Type},
     forall {b : Type}, (a -> b) -> MaybeMap inst_m a -> MaybeMap inst_m b :=
  fun {a : Type} {b : Type} => mapMb.

Program Instance TrieMap__MaybeMap {m : Type -> Type} `{TrieMap m}
   : TrieMap (MaybeMap m) :=
  {
  Key := TrieMap__MaybeMap_Key ;
  alterTM := fun {b : Type} => TrieMap__MaybeMap_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__MaybeMap_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__MaybeMap_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__MaybeMap_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__MaybeMap_mapTM }.

Local Definition TrieMap__ListMap_Key {m : Type -> Type} `{TrieMap m} : Type :=
  list (Key m).

Axiom xtList : forall {m} {k} {a},
               forall `{TrieMap m},
               (forall {b}, k -> XT b -> m b -> m b) ->
               list k -> XT a -> ListMap m a -> ListMap m a.

Local Definition TrieMap__ListMap_alterTM {inst_m : Type -> Type} `{TrieMap
  inst_m}
   : forall {b : Type},
     TrieMap__ListMap_Key -> XT b -> ListMap inst_m b -> ListMap inst_m b :=
  fun {b : Type} => xtList (fun {b} => alterTM).

Axiom TrieMap__ListMap_emptyTM : forall {m} {a} `{TrieMap m}, ListMap m a.

Axiom fdList : forall {m} {a} {b},
               forall `{TrieMap m}, (a -> b -> b) -> ListMap m a -> b -> b.

Local Definition TrieMap__ListMap_foldTM {inst_m : Type -> Type} `{TrieMap
  inst_m}
   : forall {a : Type},
     forall {b : Type}, (a -> b -> b) -> ListMap inst_m a -> b -> b :=
  fun {a : Type} {b : Type} => fdList.

Axiom lkList : forall {m} {k} {a},
               forall `{TrieMap m},
               (forall {b}, k -> m b -> option b) -> list k -> ListMap m a -> option a.

Local Definition TrieMap__ListMap_lookupTM {inst_m : Type -> Type} `{TrieMap
  inst_m}
   : forall {b : Type}, TrieMap__ListMap_Key -> ListMap inst_m b -> option b :=
  fun {b : Type} => lkList (fun {b} => lookupTM).

Axiom mapList : forall {m} {a} {b},
                forall `{TrieMap m}, (a -> b) -> ListMap m a -> ListMap m b.

Local Definition TrieMap__ListMap_mapTM {inst_m : Type -> Type} `{TrieMap
  inst_m}
   : forall {a : Type},
     forall {b : Type}, (a -> b) -> ListMap inst_m a -> ListMap inst_m b :=
  fun {a : Type} {b : Type} => mapList.

Program Instance TrieMap__ListMap {m : Type -> Type} `{TrieMap m}
   : TrieMap (ListMap m) :=
  {
  Key := TrieMap__ListMap_Key ;
  alterTM := fun {b : Type} => TrieMap__ListMap_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__ListMap_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__ListMap_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__ListMap_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__ListMap_mapTM }.

(* Skipping all instances of class `Outputable.Outputable', including
   `TrieMap.Outputable__ListMap' *)

(* Skipping all instances of class `Outputable.Outputable', including
   `TrieMap.Outputable__GenMap' *)

Axiom GenMap__EmptyMap : forall {m} {a}, GenMap m a.

Axiom fdG : forall {m} {a} {b},
            forall `{TrieMap m}, (a -> b -> b) -> GenMap m a -> b -> b.

Axiom lkG : forall {m} {a} `{TrieMap m} `{GHC.Base.Eq_ (Key m)},
            Key m -> GenMap m a -> option a.

Axiom mapG : forall {m} {a} {b},
             forall `{TrieMap m}, (a -> b) -> GenMap m a -> GenMap m b.

Axiom xtG : forall {m} {a} `{TrieMap m} `{GHC.Base.Eq_ (Key m)},
            Key m -> XT a -> GenMap m a -> GenMap m a.

Instance TrieMap__GenMap {m} `{TrieMap m} `{GHC.Base.Eq_ (Key m)}
   : TrieMap (GenMap m) :=
  Build_TrieMap (GenMap m) (Key m) (fun {b} => xtG) (fun {a} => GenMap__EmptyMap)
                (fun {a} {b} => fdG) (fun {a} => lkG) (fun {a} {b} => mapG).

Local Definition TrieMap__CoreMap_Key : Type :=
  Core.CoreExpr.

Definition emptyCME : CmEnv :=
  CME #0 Core.emptyVarEnv.

Definition deBruijnize {a} : a -> DeBruijn a :=
  D emptyCME.

Local Definition TrieMap__CoreMapX_Key : Type :=
  DeBruijn Core.CoreExpr.

Axiom xtE : forall {a},
            DeBruijn Core.CoreExpr -> XT a -> CoreMapX a -> CoreMapX a.

Local Definition TrieMap__CoreMapX_alterTM
   : forall {b : Type},
     TrieMap__CoreMapX_Key -> XT b -> CoreMapX b -> CoreMapX b :=
  fun {b : Type} => xtE.

Axiom emptyE : forall {a}, CoreMapX a.

Local Definition TrieMap__CoreMapX_emptyTM : forall {a : Type}, CoreMapX a :=
  fun {a : Type} => emptyE.

Axiom fdE : forall {a} {b}, (a -> b -> b) -> CoreMapX a -> b -> b.

Local Definition TrieMap__CoreMapX_foldTM
   : forall {a : Type},
     forall {b : Type}, (a -> b -> b) -> CoreMapX a -> b -> b :=
  fun {a : Type} {b : Type} => fdE.

Axiom lkE : forall {a}, DeBruijn Core.CoreExpr -> CoreMapX a -> option a.

Local Definition TrieMap__CoreMapX_lookupTM
   : forall {b : Type}, TrieMap__CoreMapX_Key -> CoreMapX b -> option b :=
  fun {b : Type} => lkE.

Axiom mapE : forall {a} {b}, (a -> b) -> CoreMapX a -> CoreMapX b.

Local Definition TrieMap__CoreMapX_mapTM
   : forall {a : Type}, forall {b : Type}, (a -> b) -> CoreMapX a -> CoreMapX b :=
  fun {a : Type} {b : Type} => mapE.

Instance Eq___DeBruijn__CoreExpr : GHC.Base.Eq_ (DeBruijn Core.CoreExpr).
Proof.
Admitted.

Program Instance TrieMap__CoreMapX : TrieMap CoreMapX :=
  {
  Key := TrieMap__CoreMapX_Key ;
  alterTM := fun {b : Type} => TrieMap__CoreMapX_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__CoreMapX_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__CoreMapX_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__CoreMapX_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__CoreMapX_mapTM }.

Instance TrieMap__CoreMapG : TrieMap CoreMapG := TrieMap__GenMap.

Local Definition TrieMap__CoreMap_alterTM
   : forall {b : Type}, TrieMap__CoreMap_Key -> XT b -> CoreMap b -> CoreMap b :=
  fun {b : Type} =>
    fun arg_0__ arg_1__ arg_2__ =>
      match arg_0__, arg_1__, arg_2__ with
      | k, f, Mk_CoreMap m => Mk_CoreMap (alterTM (m := CoreMapG) (deBruijnize k) f m)
      end.

Local Definition TrieMap__CoreMap_emptyTM : forall {a : Type}, CoreMap a :=
  fun {a : Type} => Mk_CoreMap emptyTM.

Local Definition TrieMap__CoreMap_foldTM
   : forall {a : Type}, forall {b : Type}, (a -> b -> b) -> CoreMap a -> b -> b :=
  fun {a : Type} {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | k, Mk_CoreMap m => foldTM k m
      end.

Local Definition TrieMap__CoreMap_lookupTM
   : forall {b : Type}, TrieMap__CoreMap_Key -> CoreMap b -> option b :=
  fun {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | k, Mk_CoreMap m => lookupTM (m := CoreMapG) (deBruijnize k) m
      end.

Local Definition TrieMap__CoreMap_mapTM
   : forall {a : Type}, forall {b : Type}, (a -> b) -> CoreMap a -> CoreMap b :=
  fun {a : Type} {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | f, Mk_CoreMap m => Mk_CoreMap (mapTM f m)
      end.

Program Instance TrieMap__CoreMap : TrieMap CoreMap :=
  {
  Key := TrieMap__CoreMap_Key ;
  alterTM := fun {b : Type} => TrieMap__CoreMap_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__CoreMap_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__CoreMap_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__CoreMap_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__CoreMap_mapTM }.

(* Skipping all instances of class `Outputable.Outputable', including
   `TrieMap.Outputable__CoreMap' *)

Local Definition TrieMap__AltMap_Key : Type :=
  Core.CoreAlt.

Definition deMaybe {m} {a} `{TrieMap m} : option (m a) -> m a :=
  fun arg_0__ => match arg_0__ with | None => emptyTM | Some m => m end.

Definition op_zbzgzg__ {m2 : Type -> Type} {a : Type} {m1 : Type -> Type}
  `{TrieMap m2}
   : (XT (m2 a) -> m1 (m2 a) -> m1 (m2 a)) ->
     (m2 a -> m2 a) -> m1 (m2 a) -> m1 (m2 a) :=
  fun f g => f (Some GHC.Base.∘ (g GHC.Base.∘ deMaybe)).

Notation "'_|>>_'" := (op_zbzgzg__).

Infix "|>>" := (_|>>_) (at level 99).

Definition extendCME : CmEnv -> Core.Var -> CmEnv :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | CME bv env, v => CME (bv GHC.Num.+ #1) (Core.extendVarEnv env v bv)
    end.

Definition extendCMEs : CmEnv -> list Core.Var -> CmEnv :=
  fun env vs => Data.Foldable.foldl extendCME env vs.

Definition xtDNamed {n : Type} {a : Type} `{Name.NamedThing n}
   : n -> XT a -> NameEnv.DNameEnv a -> NameEnv.DNameEnv a :=
  fun tc f m => NameEnv.alterDNameEnv f m (Name.getName tc).

Definition xtLit {a}
   : Literal.Literal -> XT a -> LiteralMap a -> LiteralMap a :=
  alterTM (m := LiteralMap).

Definition xtA {a} : CmEnv -> Core.CoreAlt -> XT a -> AltMap a -> AltMap a :=
  fun arg_0__ arg_1__ arg_2__ arg_3__ =>
    match arg_0__, arg_1__, arg_2__, arg_3__ with
    | env, pair (pair Core.DEFAULT _) rhs, f, m =>
        let 'AM am_deflt_4__ am_data_5__ am_lit_6__ := m in
        AM (am_deflt m |> xtG (m := CoreMapX) (D env rhs) f) am_data_5__ am_lit_6__
    | env, pair (pair (Core.LitAlt l) _) rhs, f, m =>
        let 'AM am_deflt_10__ am_data_11__ am_lit_12__ := m in
        AM am_deflt_10__ am_data_11__ (am_lit m |>
            (xtLit (a := CoreMapG a) l |>> xtG (m := CoreMapX) (D env rhs) f))
    | env, pair (pair (Core.DataAlt d) bs) rhs, f, m =>
        let 'AM am_deflt_16__ am_data_17__ am_lit_18__ := m in
        AM am_deflt_16__ (am_data m |>
            (xtDNamed (a := CoreMapG a) d |>>
             xtG (m := CoreMapX) (D (extendCMEs env bs) rhs) f)) am_lit_18__
    end.

Local Definition TrieMap__AltMap_alterTM
   : forall {b : Type}, TrieMap__AltMap_Key -> XT b -> AltMap b -> AltMap b :=
  fun {b : Type} => xtA emptyCME.

Definition emptyLiteralMap {a} : LiteralMap a :=
  emptyTM.

Local Definition TrieMap__AltMap_emptyTM : forall {a : Type}, AltMap a :=
  fun {a : Type} => AM emptyTM NameEnv.emptyDNameEnv emptyLiteralMap.

Definition fdA {a} {b} : (a -> b -> b) -> AltMap a -> b -> b :=
  fun k m =>
    foldTM k (am_deflt m) GHC.Base.∘
    (foldTM (foldTM k) (am_data m) GHC.Base.∘ foldTM (foldTM k) (am_lit m)).

Local Definition TrieMap__AltMap_foldTM
   : forall {a : Type}, forall {b : Type}, (a -> b -> b) -> AltMap a -> b -> b :=
  fun {a : Type} {b : Type} => fdA.

Axiom lkA : forall {a}, CmEnv -> Core.CoreAlt -> AltMap a -> option a.

Local Definition TrieMap__AltMap_lookupTM
   : forall {b : Type}, TrieMap__AltMap_Key -> AltMap b -> option b :=
  fun {b : Type} => lkA emptyCME.

Definition mapA {a} {b} : (a -> b) -> AltMap a -> AltMap b :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | f, AM adeflt adata alit =>
        AM (mapTM f adeflt) (mapTM (mapTM f) adata) (mapTM (mapTM f) alit)
    end.

Local Definition TrieMap__AltMap_mapTM
   : forall {a : Type}, forall {b : Type}, (a -> b) -> AltMap a -> AltMap b :=
  fun {a : Type} {b : Type} => mapA.

Program Instance TrieMap__AltMap : TrieMap AltMap :=
  {
  Key := TrieMap__AltMap_Key ;
  alterTM := fun {b : Type} => TrieMap__AltMap_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__AltMap_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__AltMap_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__AltMap_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__AltMap_mapTM }.

Instance Eq___DeBruijn__CoreAlt : GHC.Base.Eq_ (DeBruijn Core.CoreAlt).
Proof.
Admitted.

Local Definition TrieMap__CoercionMap_Key : Type :=
  AxiomatizedTypes.Coercion.

Local Definition TrieMap__CoercionMapX_Key : Type :=
  DeBruijn AxiomatizedTypes.Coercion.

Axiom xtT : forall {a},
            DeBruijn AxiomatizedTypes.Type_ -> XT a -> TypeMapX a -> TypeMapX a.

Definition xtC {a}
   : DeBruijn AxiomatizedTypes.Coercion ->
     XT a -> CoercionMapX a -> CoercionMapX a :=
  fun arg_0__ arg_1__ arg_2__ =>
    match arg_0__, arg_1__, arg_2__ with
    | D env co, f, Mk_CoercionMapX m =>
        Mk_CoercionMapX (xtT (D env (Core.coercionType co)) f m)
    end.

Local Definition TrieMap__CoercionMapX_alterTM
   : forall {b : Type},
     TrieMap__CoercionMapX_Key -> XT b -> CoercionMapX b -> CoercionMapX b :=
  fun {b : Type} => xtC.

Local Definition TrieMap__TypeMapX_Key : Type :=
  DeBruijn AxiomatizedTypes.Type_.

Local Definition TrieMap__TypeMapX_alterTM
   : forall {b : Type},
     TrieMap__TypeMapX_Key -> XT b -> TypeMapX b -> TypeMapX b :=
  fun {b : Type} => xtT.

Axiom emptyT : forall {a}, TypeMapX a.

Local Definition TrieMap__TypeMapX_emptyTM : forall {a : Type}, TypeMapX a :=
  fun {a : Type} => emptyT.

Axiom fdT : forall {a} {b}, (a -> b -> b) -> TypeMapX a -> b -> b.

Local Definition TrieMap__TypeMapX_foldTM
   : forall {a : Type},
     forall {b : Type}, (a -> b -> b) -> TypeMapX a -> b -> b :=
  fun {a : Type} {b : Type} => fdT.

Axiom lkT : forall {a},
            DeBruijn AxiomatizedTypes.Type_ -> TypeMapX a -> option a.

Local Definition TrieMap__TypeMapX_lookupTM
   : forall {b : Type}, TrieMap__TypeMapX_Key -> TypeMapX b -> option b :=
  fun {b : Type} => lkT.

Axiom mapT : forall {a} {b}, (a -> b) -> TypeMapX a -> TypeMapX b.

Local Definition TrieMap__TypeMapX_mapTM
   : forall {a : Type}, forall {b : Type}, (a -> b) -> TypeMapX a -> TypeMapX b :=
  fun {a : Type} {b : Type} => mapT.

Program Instance TrieMap__TypeMapX : TrieMap TypeMapX :=
  {
  Key := TrieMap__TypeMapX_Key ;
  alterTM := fun {b : Type} => TrieMap__TypeMapX_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__TypeMapX_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__TypeMapX_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__TypeMapX_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__TypeMapX_mapTM }.

Local Definition TrieMap__CoercionMapX_emptyTM
   : forall {a : Type}, CoercionMapX a :=
  fun {a : Type} => Mk_CoercionMapX emptyTM.

Local Definition TrieMap__CoercionMapX_foldTM
   : forall {a : Type},
     forall {b : Type}, (a -> b -> b) -> CoercionMapX a -> b -> b :=
  fun {a : Type} {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | f, Mk_CoercionMapX core_tm => foldTM f core_tm
      end.

Definition lkC {a}
   : DeBruijn AxiomatizedTypes.Coercion -> CoercionMapX a -> option a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | D env co, Mk_CoercionMapX core_tm =>
        lkT (D env (Core.coercionType co)) core_tm
    end.

Local Definition TrieMap__CoercionMapX_lookupTM
   : forall {b : Type}, TrieMap__CoercionMapX_Key -> CoercionMapX b -> option b :=
  fun {b : Type} => lkC.

Local Definition TrieMap__CoercionMapX_mapTM
   : forall {a : Type},
     forall {b : Type}, (a -> b) -> CoercionMapX a -> CoercionMapX b :=
  fun {a : Type} {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | f, Mk_CoercionMapX core_tm => Mk_CoercionMapX (mapTM f core_tm)
      end.

Instance Eq___DeBruijn__Type_ : GHC.Base.Eq_ (DeBruijn AxiomatizedTypes.Type_).
Proof.
Admitted.

Local Definition Eq___DeBruijn__Coercion_op_zeze__
   : DeBruijn AxiomatizedTypes.Coercion ->
     DeBruijn AxiomatizedTypes.Coercion -> bool :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | D env1 co1, D env2 co2 =>
        D env1 (Core.coercionType co1) GHC.Base.== D env2 (Core.coercionType co2)
    end.

Local Definition Eq___DeBruijn__Coercion_op_zsze__
   : DeBruijn AxiomatizedTypes.Coercion ->
     DeBruijn AxiomatizedTypes.Coercion -> bool :=
  fun x y => negb (Eq___DeBruijn__Coercion_op_zeze__ x y).

Program Instance Eq___DeBruijn__Coercion
   : GHC.Base.Eq_ (DeBruijn AxiomatizedTypes.Coercion) :=
  fun _ k__ =>
    k__ {| GHC.Base.op_zeze____ := Eq___DeBruijn__Coercion_op_zeze__ ;
           GHC.Base.op_zsze____ := Eq___DeBruijn__Coercion_op_zsze__ |}.

Program Instance TrieMap__CoercionMapX : TrieMap CoercionMapX :=
  {
  Key := TrieMap__CoercionMapX_Key ;
  alterTM := fun {b : Type} => TrieMap__CoercionMapX_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__CoercionMapX_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__CoercionMapX_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__CoercionMapX_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__CoercionMapX_mapTM }.

Instance TrieMap__CoercionMapG : TrieMap CoercionMapG := TrieMap__GenMap.

Local Definition TrieMap__CoercionMap_alterTM
   : forall {b : Type},
     TrieMap__CoercionMap_Key -> XT b -> CoercionMap b -> CoercionMap b :=
  fun {b : Type} =>
    fun arg_0__ arg_1__ arg_2__ =>
      match arg_0__, arg_1__, arg_2__ with
      | k, f, Mk_CoercionMap m => Mk_CoercionMap (alterTM (deBruijnize k) f m)
      end.

Local Definition TrieMap__CoercionMap_emptyTM
   : forall {a : Type}, CoercionMap a :=
  fun {a : Type} => Mk_CoercionMap emptyTM.

Local Definition TrieMap__CoercionMap_foldTM
   : forall {a : Type},
     forall {b : Type}, (a -> b -> b) -> CoercionMap a -> b -> b :=
  fun {a : Type} {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | k, Mk_CoercionMap m => foldTM k m
      end.

Local Definition TrieMap__CoercionMap_lookupTM
   : forall {b : Type}, TrieMap__CoercionMap_Key -> CoercionMap b -> option b :=
  fun {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | k, Mk_CoercionMap m => lookupTM (deBruijnize k) m
      end.

Local Definition TrieMap__CoercionMap_mapTM
   : forall {a : Type},
     forall {b : Type}, (a -> b) -> CoercionMap a -> CoercionMap b :=
  fun {a : Type} {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | f, Mk_CoercionMap m => Mk_CoercionMap (mapTM f m)
      end.

Program Instance TrieMap__CoercionMap : TrieMap CoercionMap :=
  {
  Key := TrieMap__CoercionMap_Key ;
  alterTM := fun {b : Type} => TrieMap__CoercionMap_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__CoercionMap_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__CoercionMap_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__CoercionMap_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__CoercionMap_mapTM }.

(* Skipping all instances of class `Outputable.Outputable', including
   `TrieMap.Outputable__TypeMapG' *)

Instance TrieMap__TyLitMap : TrieMap TyLitMap.
Proof.
Admitted.

Local Definition TrieMap__TypeMap_Key : Type :=
  AxiomatizedTypes.Type_.

Instance TrieMap__TypeMapG : TrieMap TypeMapG := TrieMap__GenMap.

Definition xtTT {a}
   : DeBruijn AxiomatizedTypes.Type_ -> XT a -> TypeMap a -> TypeMap a :=
  fun arg_0__ arg_1__ arg_2__ =>
    match arg_0__, arg_1__, arg_2__ with
    | D env ty, f, Mk_TypeMap m =>
        Mk_TypeMap (m |>
                    (xtG (m := TypeMapX) (D env (Core.typeKind ty)) |>>
                     xtG (m := TypeMapX) (D env ty) f))
    end.

Local Definition TrieMap__TypeMap_alterTM
   : forall {b : Type}, TrieMap__TypeMap_Key -> XT b -> TypeMap b -> TypeMap b :=
  fun {b : Type} => fun k f m => xtTT (deBruijnize k) f m.

Local Definition TrieMap__TypeMap_emptyTM : forall {a : Type}, TypeMap a :=
  fun {a : Type} => Mk_TypeMap emptyTM.

Local Definition TrieMap__TypeMap_foldTM
   : forall {a : Type}, forall {b : Type}, (a -> b -> b) -> TypeMap a -> b -> b :=
  fun {a : Type} {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | k, Mk_TypeMap m => foldTM (foldTM k) m
      end.

Definition lkTT {a}
   : DeBruijn AxiomatizedTypes.Type_ -> TypeMap a -> option a :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | D env ty, Mk_TypeMap m =>
        GHC.Base.op_zgzgze__ (m := option) (lkG (m := TypeMapX) (D env (Core.typeKind
                                                                        ty)) m) (lkG (m := TypeMapX) (D env ty))
    end.

Local Definition TrieMap__TypeMap_lookupTM
   : forall {b : Type}, TrieMap__TypeMap_Key -> TypeMap b -> option b :=
  fun {b : Type} => fun k m => lkTT (deBruijnize k) m.

Local Definition TrieMap__TypeMap_mapTM
   : forall {a : Type}, forall {b : Type}, (a -> b) -> TypeMap a -> TypeMap b :=
  fun {a : Type} {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | f, Mk_TypeMap m => Mk_TypeMap (mapTM (mapTM f) m)
      end.

Program Instance TrieMap__TypeMap : TrieMap TypeMap :=
  {
  Key := TrieMap__TypeMap_Key ;
  alterTM := fun {b : Type} => TrieMap__TypeMap_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__TypeMap_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__TypeMap_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__TypeMap_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__TypeMap_mapTM }.

Local Definition TrieMap__LooseTypeMap_Key : Type :=
  AxiomatizedTypes.Type_.

Local Definition TrieMap__LooseTypeMap_alterTM
   : forall {b : Type},
     TrieMap__LooseTypeMap_Key -> XT b -> LooseTypeMap b -> LooseTypeMap b :=
  fun {b : Type} =>
    fun arg_0__ arg_1__ arg_2__ =>
      match arg_0__, arg_1__, arg_2__ with
      | k, f, Mk_LooseTypeMap m =>
          Mk_LooseTypeMap (alterTM (m := TypeMapG) (deBruijnize k) f m)
      end.

Local Definition TrieMap__LooseTypeMap_emptyTM
   : forall {a : Type}, LooseTypeMap a :=
  fun {a : Type} => Mk_LooseTypeMap emptyTM.

Local Definition TrieMap__LooseTypeMap_foldTM
   : forall {a : Type},
     forall {b : Type}, (a -> b -> b) -> LooseTypeMap a -> b -> b :=
  fun {a : Type} {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | f, Mk_LooseTypeMap m => foldTM f m
      end.

Local Definition TrieMap__LooseTypeMap_lookupTM
   : forall {b : Type}, TrieMap__LooseTypeMap_Key -> LooseTypeMap b -> option b :=
  fun {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | k, Mk_LooseTypeMap m => lookupTM (m := TypeMapG) (deBruijnize k) m
      end.

Local Definition TrieMap__LooseTypeMap_mapTM
   : forall {a : Type},
     forall {b : Type}, (a -> b) -> LooseTypeMap a -> LooseTypeMap b :=
  fun {a : Type} {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | f, Mk_LooseTypeMap m => Mk_LooseTypeMap (mapTM f m)
      end.

Program Instance TrieMap__LooseTypeMap : TrieMap LooseTypeMap :=
  {
  Key := TrieMap__LooseTypeMap_Key ;
  alterTM := fun {b : Type} => TrieMap__LooseTypeMap_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__LooseTypeMap_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__LooseTypeMap_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__LooseTypeMap_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__LooseTypeMap_mapTM }.

Definition Eq___DeBruijn__list_op_zeze__ {a} `{GHC.Base.Eq_ (DeBruijn a)}
  (dbl_xs dbl_ys : DeBruijn (list a))
   : bool :=
  match dbl_xs, dbl_ys with
  | D env_xs xs0, D env_ys ys0 =>
      let fix equal xs ys
        := match xs, ys with
           | nil, nil => true
           | cons x xs', cons y ys' =>
               andb (D env_xs x GHC.Base.== D env_ys y) (equal xs' ys')
           | _, _ => false
           end in
      equal xs0 ys0
  end.

Local Definition Eq___DeBruijn__list_op_zsze__ {inst_a : Type} `{GHC.Base.Eq_
  (DeBruijn inst_a)}
   : DeBruijn (list inst_a) -> DeBruijn (list inst_a) -> bool :=
  fun x y => negb (Eq___DeBruijn__list_op_zeze__ x y).

Program Instance Eq___DeBruijn__list {a : Type} `{GHC.Base.Eq_ (DeBruijn a)}
   : GHC.Base.Eq_ (DeBruijn (list a)) :=
  fun _ k__ =>
    k__ {| GHC.Base.op_zeze____ := Eq___DeBruijn__list_op_zeze__ ;
           GHC.Base.op_zsze____ := Eq___DeBruijn__list_op_zsze__ |}.

Local Definition TrieMap__VarMap_Key : Type :=
  Core.Var.

Definition lookupCME : CmEnv -> Core.Var -> option BoundVar :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | CME _ env, v => Core.lookupVarEnv env v
    end.

Definition xtDFreeVar {a : Type}
   : Core.Var -> XT a -> Core.DVarEnv a -> Core.DVarEnv a :=
  fun v f m => Core.alterDVarEnv f m v.

Definition xtVar {a} : CmEnv -> Core.Var -> XT a -> VarMap a -> VarMap a :=
  fun env v f m =>
    match lookupCME env v with
    | Some bv =>
        let 'VM vm_bvar_0__ vm_fvar_1__ := m in
        VM (vm_bvar m |> alterTM (m := BoundVarMap) bv f) vm_fvar_1__
    | _ =>
        let 'VM vm_bvar_4__ vm_fvar_5__ := m in
        VM vm_bvar_4__ (vm_fvar m |> xtDFreeVar v f)
    end.

Local Definition TrieMap__VarMap_alterTM
   : forall {b : Type}, TrieMap__VarMap_Key -> XT b -> VarMap b -> VarMap b :=
  fun {b : Type} => xtVar emptyCME.

Local Definition TrieMap__VarMap_emptyTM : forall {a : Type}, VarMap a :=
  fun {a : Type} => VM IntMap.empty Core.emptyDVarEnv.

Definition fdVar {a} {b} : (a -> b -> b) -> VarMap a -> b -> b :=
  fun k m => foldTM k (vm_bvar m) GHC.Base.∘ foldTM k (vm_fvar m).

Local Definition TrieMap__VarMap_foldTM
   : forall {a : Type}, forall {b : Type}, (a -> b -> b) -> VarMap a -> b -> b :=
  fun {a : Type} {b : Type} => fdVar.

Definition lkDFreeVar {a : Type} : Core.Var -> Core.DVarEnv a -> option a :=
  fun var env => Core.lookupDVarEnv env var.

Definition lkVar {a} : CmEnv -> Core.Var -> VarMap a -> option a :=
  fun env v =>
    match lookupCME env v with
    | Some bv => vm_bvar >.> lookupTM (m := BoundVarMap) bv
    | _ => vm_fvar >.> lkDFreeVar v
    end.

Local Definition TrieMap__VarMap_lookupTM
   : forall {b : Type}, TrieMap__VarMap_Key -> VarMap b -> option b :=
  fun {b : Type} => lkVar emptyCME.

Definition mapVar {a} {b} : (a -> b) -> VarMap a -> VarMap b :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | f, VM bv fv => VM (mapTM f bv) (mapTM f fv)
    end.

Local Definition TrieMap__VarMap_mapTM
   : forall {a : Type}, forall {b : Type}, (a -> b) -> VarMap a -> VarMap b :=
  fun {a : Type} {b : Type} => mapVar.

Program Instance TrieMap__VarMap : TrieMap VarMap :=
  {
  Key := TrieMap__VarMap_Key ;
  alterTM := fun {b : Type} => TrieMap__VarMap_alterTM ;
  emptyTM := fun {a : Type} => TrieMap__VarMap_emptyTM ;
  foldTM := fun {a : Type} {b : Type} => TrieMap__VarMap_foldTM ;
  lookupTM := fun {b : Type} => TrieMap__VarMap_lookupTM ;
  mapTM := fun {a : Type} {b : Type} => TrieMap__VarMap_mapTM }.

Definition insertTM {m : Type -> Type} {a : Type} `{TrieMap m}
   : Key m -> a -> m a -> m a :=
  fun k v m => alterTM k (fun arg_0__ => Some v) m.

Definition deleteTM {m : Type -> Type} {a : Type} `{TrieMap m}
   : Key m -> m a -> m a :=
  fun k m => alterTM k (fun arg_0__ => None) m.

Definition lkDNamed {n : Type} {a : Type} `{Name.NamedThing n}
   : n -> NameEnv.DNameEnv a -> option a :=
  fun n env => NameEnv.lookupDNameEnv env (Name.getName n).

Definition lkLit {a} : Literal.Literal -> LiteralMap a -> option a :=
  lookupTM (m := LiteralMap).

Definition lookupCoreMap {a : Type} : CoreMap a -> Core.CoreExpr -> option a :=
  fun cm e => lookupTM (m := CoreMap) e cm.

Definition extendCoreMap {a : Type}
   : CoreMap a -> Core.CoreExpr -> a -> CoreMap a :=
  fun m e v => alterTM (m := CoreMap) e (fun arg_0__ => Some v) m.

Definition foldCoreMap {a : Type} {b : Type}
   : (a -> b -> b) -> b -> CoreMap a -> b :=
  fun k z m => foldTM k m z.

Definition emptyCoreMap {a : Type} : CoreMap a :=
  emptyTM.

Definition lkTickish {a} : Core.Tickish Core.Id -> TickishMap a -> option a :=
  lookupTM (m := TickishMap).

Definition xtTickish {a}
   : Core.Tickish Core.Id -> XT a -> TickishMap a -> TickishMap a :=
  alterTM (m := TickishMap).

Axiom trieMapView : AxiomatizedTypes.Type_ -> option AxiomatizedTypes.Type_.

Definition emptyTyLitMap {a} : TyLitMap a :=
  TLM Data.Map.Internal.empty Data.Map.Internal.empty.

Definition mapTyLit {a} {b} : (a -> b) -> TyLitMap a -> TyLitMap b :=
  fun arg_0__ arg_1__ =>
    match arg_0__, arg_1__ with
    | f, TLM tn ts => TLM (Data.Map.Internal.map f tn) (Data.Map.Internal.map f ts)
    end.

(* Skipping definition `TrieMap.lkTyLit' *)

(* Skipping definition `TrieMap.xtTyLit' *)

Definition foldTyLit {a} {b} : (a -> b -> b) -> TyLitMap a -> b -> b :=
  fun l m =>
    GHC.Base.flip (Data.Map.Internal.foldr l) (tlm_string m) GHC.Base.∘
    GHC.Base.flip (Data.Map.Internal.foldr l) (tlm_number m).

Definition foldTypeMap {a : Type} {b : Type}
   : (a -> b -> b) -> b -> TypeMap a -> b :=
  fun k z m => foldTM k m z.

Definition emptyTypeMap {a : Type} : TypeMap a :=
  emptyTM.

Definition lookupTypeMap {a : Type}
   : TypeMap a -> AxiomatizedTypes.Type_ -> option a :=
  fun cm t => lookupTM (m := TypeMap) t cm.

Definition extendTypeMap {a : Type}
   : TypeMap a -> AxiomatizedTypes.Type_ -> a -> TypeMap a :=
  fun m t v => alterTM (m := TypeMap) t (GHC.Base.const (Some v)) m.

Definition lookupTypeMapWithScope {a : Type}
   : TypeMap a -> CmEnv -> AxiomatizedTypes.Type_ -> option a :=
  fun m cm t => lkTT (D cm t) m.

Definition extendTypeMapWithScope {a : Type}
   : TypeMap a -> CmEnv -> AxiomatizedTypes.Type_ -> a -> TypeMap a :=
  fun m cm t v => xtTT (D cm t) (GHC.Base.const (Some v)) m.

Definition mkDeBruijnContext : list Core.Var -> CmEnv :=
  extendCMEs emptyCME.

Axiom lkBndr : forall {a}, CmEnv -> Core.Var -> BndrMap a -> option a.

Definition xtBndr {a} : CmEnv -> Core.Var -> XT a -> BndrMap a -> BndrMap a :=
  fun env v f => xtG (m := TypeMapX) (D env (Core.varType v)) f.

Module Notations.
Notation "'_TrieMap.|>_'" := (op_zbzg__).
Infix "TrieMap.|>" := (_|>_) (at level 99).
Notation "'_TrieMap.>.>_'" := (op_zgzizg__).
Infix "TrieMap.>.>" := (_>.>_) (at level 99).
Notation "'_TrieMap.|>>_'" := (op_zbzgzg__).
Infix "TrieMap.|>>" := (_|>>_) (at level 99).
End Notations.

(* External variables:
     Build_TrieMap Key None Some Type andb bool cons false list negb option pair true
     AxiomatizedTypes.Coercion AxiomatizedTypes.Type_ Core.CoreAlt Core.CoreExpr
     Core.DEFAULT Core.DVarEnv Core.DataAlt Core.Id Core.LitAlt Core.Tickish Core.Var
     Core.VarEnv Core.alterDVarEnv Core.coercionType Core.emptyDVarEnv
     Core.emptyVarEnv Core.extendVarEnv Core.lookupDVarEnv Core.lookupVarEnv
     Core.typeKind Core.varType Data.Foldable.foldl Data.IntSet.Internal.Key
     Data.Map.Internal.Map Data.Map.Internal.alter Data.Map.Internal.empty
     Data.Map.Internal.foldr Data.Map.Internal.lookup Data.Map.Internal.map
     FastString.FastString GHC.Base.Eq_ GHC.Base.Ord GHC.Base.const GHC.Base.flip
     GHC.Base.fmap GHC.Base.op_z2218U__ GHC.Base.op_zeze__ GHC.Base.op_zeze____
     GHC.Base.op_zgzgze__ GHC.Base.op_zsze____ GHC.Num.Integer GHC.Num.fromInteger
     GHC.Num.op_zp__ HsToCoq.Err.Build_Default HsToCoq.Err.Default
     HsToCoq.Err.default IntMap.IntMap IntMap.alter IntMap.empty IntMap.foldr
     IntMap.lookup IntMap.map Literal.Literal Name.NamedThing Name.getName
     NameEnv.DNameEnv NameEnv.alterDNameEnv NameEnv.emptyDNameEnv
     NameEnv.lookupDNameEnv UniqFM.UniqFM UniqFM.alterUFM UniqFM.emptyUFM
     UniqFM.lookupUFM UniqFM.mapUFM UniqFM.nonDetFoldUFM Unique.Unique
*)
