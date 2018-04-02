(* Default settings (from HsToCoq.Coq.Preamble) *)

Generalizable All Variables.

Unset Implicit Arguments.
Set Maximal Implicit Insertion.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

Require Coq.Program.Tactics.
Require Coq.Program.Wf.

(* Converted imports: *)

Require Coq.Program.Basics.
Require Data.Foldable.
Require GHC.Base.
Require GHC.Num.
Require GHC.Prim.
Import GHC.Base.Notations.
Import GHC.Num.Notations.

(* Converted type declarations: *)

Inductive Identity a : Type := Mk_Identity : a -> Identity a.

Arguments Mk_Identity {_} _.

Definition runIdentity {a} (arg_0__ : Identity a) :=
  let 'Mk_Identity runIdentity := arg_0__ in
  runIdentity.
(* Midamble *)

Instance Unpeel_Identity a : Prim.Unpeel (Identity a) a :=
 Prim.Build_Unpeel _ _  (fun arg => match arg with | Mk_Identity x => x end) Mk_Identity.

(* Converted value declarations: *)

(* Translating `instance Read__Identity' failed: OOPS! Cannot find information
   for class Qualified "GHC.Read" "Read" unsupported *)

(* Translating `instance Show__Identity' failed: OOPS! Cannot find information
   for class Qualified "GHC.Show" "Show" unsupported *)

Local Definition Foldable__Identity_elem
   : forall {a}, forall `{GHC.Base.Eq_ a}, a -> Identity a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} =>
    Coq.Program.Basics.compose (fun arg_0__ => arg_0__ GHC.Base.∘ runIdentity)
                               _GHC.Base.==_.

Local Definition Foldable__Identity_foldMap
   : forall {m} {a}, forall `{GHC.Base.Monoid m}, (a -> m) -> Identity a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} => GHC.Prim.coerce.

Local Definition Foldable__Identity_fold
   : forall {m}, forall `{GHC.Base.Monoid m}, Identity m -> m :=
  fun {m} `{GHC.Base.Monoid m} => Foldable__Identity_foldMap GHC.Base.id.

Local Definition Foldable__Identity_foldl
   : forall {b} {a}, (b -> a -> b) -> b -> Identity a -> b :=
  fun {b} {a} => GHC.Prim.coerce.

Local Definition Foldable__Identity_foldl'
   : forall {b} {a}, (b -> a -> b) -> b -> Identity a -> b :=
  fun {b} {a} => GHC.Prim.coerce.

Local Definition Foldable__Identity_foldr
   : forall {a} {b}, (a -> b -> b) -> b -> Identity a -> b :=
  fun {a} {b} =>
    fun arg_0__ arg_1__ arg_2__ =>
      match arg_0__, arg_1__, arg_2__ with
      | f, z, Mk_Identity x => f x z
      end.

Local Definition Foldable__Identity_foldr'
   : forall {a} {b}, (a -> b -> b) -> b -> Identity a -> b :=
  fun {a} {b} => Foldable__Identity_foldr.

Local Definition Foldable__Identity_length
   : forall {a}, Identity a -> GHC.Num.Int :=
  fun {a} => fun arg_0__ => #1.

Local Definition Foldable__Identity_null : forall {a}, Identity a -> bool :=
  fun {a} => fun arg_0__ => false.

Local Definition Foldable__Identity_product
   : forall {a}, forall `{GHC.Num.Num a}, Identity a -> a :=
  fun {a} `{GHC.Num.Num a} => runIdentity.

Local Definition Foldable__Identity_sum
   : forall {a}, forall `{GHC.Num.Num a}, Identity a -> a :=
  fun {a} `{GHC.Num.Num a} => runIdentity.

Local Definition Foldable__Identity_toList : forall {a}, Identity a -> list a :=
  fun {a} => fun arg_0__ => let 'Mk_Identity x := arg_0__ in cons x nil.

Program Instance Foldable__Identity : Data.Foldable.Foldable Identity :=
  fun _ k =>
    k {| Data.Foldable.elem__ := fun {a} `{GHC.Base.Eq_ a} =>
           Foldable__Identity_elem ;
         Data.Foldable.fold__ := fun {m} `{GHC.Base.Monoid m} =>
           Foldable__Identity_fold ;
         Data.Foldable.foldMap__ := fun {m} {a} `{GHC.Base.Monoid m} =>
           Foldable__Identity_foldMap ;
         Data.Foldable.foldl__ := fun {b} {a} => Foldable__Identity_foldl ;
         Data.Foldable.foldl'__ := fun {b} {a} => Foldable__Identity_foldl' ;
         Data.Foldable.foldr__ := fun {a} {b} => Foldable__Identity_foldr ;
         Data.Foldable.foldr'__ := fun {a} {b} => Foldable__Identity_foldr' ;
         Data.Foldable.length__ := fun {a} => Foldable__Identity_length ;
         Data.Foldable.null__ := fun {a} => Foldable__Identity_null ;
         Data.Foldable.product__ := fun {a} `{GHC.Num.Num a} =>
           Foldable__Identity_product ;
         Data.Foldable.sum__ := fun {a} `{GHC.Num.Num a} => Foldable__Identity_sum ;
         Data.Foldable.toList__ := fun {a} => Foldable__Identity_toList |}.

Local Definition Functor__Identity_fmap
   : forall {a} {b}, (a -> b) -> Identity a -> Identity b :=
  fun {a} {b} => GHC.Prim.coerce.

Local Definition Functor__Identity_op_zlzd__
   : forall {a} {b}, a -> Identity b -> Identity a :=
  fun {a} {b} => fun x => Functor__Identity_fmap (GHC.Base.const x).

Program Instance Functor__Identity : GHC.Base.Functor Identity :=
  fun _ k =>
    k {| GHC.Base.op_zlzd____ := fun {a} {b} => Functor__Identity_op_zlzd__ ;
         GHC.Base.fmap__ := fun {a} {b} => Functor__Identity_fmap |}.

Local Definition Applicative__Identity_liftA2
   : forall {a} {b} {c},
     (a -> b -> c) -> Identity a -> Identity b -> Identity c :=
  fun {a} {b} {c} => GHC.Prim.coerce.

Local Definition Applicative__Identity_op_zlztzg__
   : forall {a} {b}, Identity (a -> b) -> Identity a -> Identity b :=
  fun {a} {b} => GHC.Prim.coerce.

Local Definition Applicative__Identity_op_ztzg__
   : forall {a} {b}, Identity a -> Identity b -> Identity b :=
  fun {a} {b} =>
    fun x y =>
      Applicative__Identity_op_zlztzg__ (GHC.Base.fmap (GHC.Base.const GHC.Base.id) x)
                                        y.

Local Definition Applicative__Identity_pure : forall {a}, a -> Identity a :=
  fun {a} => Mk_Identity.

Program Instance Applicative__Identity : GHC.Base.Applicative Identity :=
  fun _ k =>
    k {| GHC.Base.op_ztzg____ := fun {a} {b} => Applicative__Identity_op_ztzg__ ;
         GHC.Base.op_zlztzg____ := fun {a} {b} => Applicative__Identity_op_zlztzg__ ;
         GHC.Base.liftA2__ := fun {a} {b} {c} => Applicative__Identity_liftA2 ;
         GHC.Base.pure__ := fun {a} => Applicative__Identity_pure |}.

Local Definition Monad__Identity_op_zgzg__
   : forall {a} {b}, Identity a -> Identity b -> Identity b :=
  fun {a} {b} => _GHC.Base.*>_.

Local Definition Monad__Identity_op_zgzgze__
   : forall {a} {b}, Identity a -> (a -> Identity b) -> Identity b :=
  fun {a} {b} => fun m k => k (runIdentity m).

Local Definition Monad__Identity_return_ : forall {a}, a -> Identity a :=
  fun {a} => GHC.Base.pure.

Program Instance Monad__Identity : GHC.Base.Monad Identity :=
  fun _ k =>
    k {| GHC.Base.op_zgzg____ := fun {a} {b} => Monad__Identity_op_zgzg__ ;
         GHC.Base.op_zgzgze____ := fun {a} {b} => Monad__Identity_op_zgzgze__ ;
         GHC.Base.return___ := fun {a} => Monad__Identity_return_ |}.

(* Translating `instance MonadFix__Identity' failed: OOPS! Cannot find
   information for class Qualified "Control.Monad.Fix" "MonadFix" unsupported *)

(* Translating `instance Storable__Identity' failed: OOPS! Cannot find
   information for class Qualified "Foreign.Storable" "Storable" unsupported *)

(* Translating `instance RealFloat__Identity' failed: OOPS! Cannot find
   information for class Qualified "GHC.Float" "RealFloat" unsupported *)

(* Translating `instance RealFrac__Identity' failed: OOPS! Cannot find
   information for class Qualified "GHC.Real" "RealFrac" unsupported *)

(* Translating `instance Real__Identity' failed: OOPS! Cannot find information
   for class Qualified "GHC.Real" "Real" unsupported *)

Local Definition Ord__Identity_compare {inst_a} `{GHC.Base.Ord inst_a}
   : Identity inst_a -> Identity inst_a -> comparison :=
  GHC.Prim.coerce GHC.Base.compare.

Local Definition Ord__Identity_max {inst_a} `{GHC.Base.Ord inst_a}
   : Identity inst_a -> Identity inst_a -> Identity inst_a :=
  GHC.Prim.coerce GHC.Base.max.

Local Definition Ord__Identity_min {inst_a} `{GHC.Base.Ord inst_a}
   : Identity inst_a -> Identity inst_a -> Identity inst_a :=
  GHC.Prim.coerce GHC.Base.min.

Local Definition Ord__Identity_op_zg__ {inst_a} `{GHC.Base.Ord inst_a}
   : Identity inst_a -> Identity inst_a -> bool :=
  GHC.Prim.coerce _GHC.Base.>_.

Local Definition Ord__Identity_op_zgze__ {inst_a} `{GHC.Base.Ord inst_a}
   : Identity inst_a -> Identity inst_a -> bool :=
  GHC.Prim.coerce _GHC.Base.>=_.

Local Definition Ord__Identity_op_zl__ {inst_a} `{GHC.Base.Ord inst_a}
   : Identity inst_a -> Identity inst_a -> bool :=
  GHC.Prim.coerce _GHC.Base.<_.

Local Definition Ord__Identity_op_zlze__ {inst_a} `{GHC.Base.Ord inst_a}
   : Identity inst_a -> Identity inst_a -> bool :=
  GHC.Prim.coerce _GHC.Base.<=_.

(* Translating `instance Num__Identity' failed: OOPS! Cannot find information
   for class Qualified "GHC.Num" "Num" unsupported *)

Local Definition Monoid__Identity_mappend {inst_a} `{GHC.Base.Monoid inst_a}
   : Identity inst_a -> Identity inst_a -> Identity inst_a :=
  GHC.Prim.coerce GHC.Base.mappend.

Local Definition Monoid__Identity_mconcat {inst_a} `{GHC.Base.Monoid inst_a}
   : list (Identity inst_a) -> Identity inst_a :=
  GHC.Prim.coerce GHC.Base.mconcat.

Local Definition Monoid__Identity_mempty {inst_a} `{GHC.Base.Monoid inst_a}
   : Identity inst_a :=
  GHC.Prim.coerce GHC.Base.mempty.

Local Definition Semigroup__Identity_op_zlzlzgzg__ {inst_a} `{GHC.Base.Semigroup
  inst_a}
   : Identity inst_a -> Identity inst_a -> Identity inst_a :=
  GHC.Prim.coerce _GHC.Base.<<>>_.

Program Instance Semigroup__Identity {a} `{GHC.Base.Semigroup a}
   : GHC.Base.Semigroup (Identity a) :=
  fun _ k =>
    k {| GHC.Base.op_zlzlzgzg____ := Semigroup__Identity_op_zlzlzgzg__ |}.

Program Instance Monoid__Identity {a} `{GHC.Base.Monoid a}
   : GHC.Base.Monoid (Identity a) :=
  fun _ k =>
    k {| GHC.Base.mappend__ := Monoid__Identity_mappend ;
         GHC.Base.mconcat__ := Monoid__Identity_mconcat ;
         GHC.Base.mempty__ := Monoid__Identity_mempty |}.

(* Translating `instance Ix__Identity' failed: OOPS! Cannot find information for
   class Qualified "GHC.Arr" "Ix" unsupported *)

(* Translating `instance Integral__Identity' failed: OOPS! Cannot find
   information for class Qualified "GHC.Real" "Integral" unsupported *)

(* Translating `instance Generic1__TYPE__Identity__LiftedRep' failed: type class
   instance head:App (App (Qualid (Qualified "GHC.Generics" "Generic1")) (PosArg
   (App (Qualid (Qualified "GHC.Prim" "TYPE")) (PosArg (Qualid (Qualified
   "GHC.Types" "LiftedRep")) :| [])) :| [])) (PosArg (Qualid (Qualified
   "Data.Functor.Identity" "Identity")) :| []) unsupported *)

(* Translating `instance Generic__Identity' failed: OOPS! Cannot find
   information for class Qualified "GHC.Generics" "Generic" unsupported *)

(* Translating `instance Fractional__Identity' failed: OOPS! Cannot find
   information for class Qualified "GHC.Real" "Fractional" unsupported *)

(* Translating `instance Floating__Identity' failed: OOPS! Cannot find
   information for class Qualified "GHC.Float" "Floating" unsupported *)

(* Translating `instance FiniteBits__Identity' failed: OOPS! Cannot find
   information for class Qualified "Data.Bits" "FiniteBits" unsupported *)

Local Definition Eq___Identity_op_zeze__ {inst_a} `{GHC.Base.Eq_ inst_a}
   : Identity inst_a -> Identity inst_a -> bool :=
  GHC.Prim.coerce _GHC.Base.==_.

Local Definition Eq___Identity_op_zsze__ {inst_a} `{GHC.Base.Eq_ inst_a}
   : Identity inst_a -> Identity inst_a -> bool :=
  GHC.Prim.coerce _GHC.Base./=_.

Program Instance Eq___Identity {a} `{GHC.Base.Eq_ a}
   : GHC.Base.Eq_ (Identity a) :=
  fun _ k =>
    k {| GHC.Base.op_zeze____ := Eq___Identity_op_zeze__ ;
         GHC.Base.op_zsze____ := Eq___Identity_op_zsze__ |}.

Program Instance Ord__Identity {a} `{GHC.Base.Ord a}
   : GHC.Base.Ord (Identity a) :=
  fun _ k =>
    k {| GHC.Base.op_zl____ := Ord__Identity_op_zl__ ;
         GHC.Base.op_zlze____ := Ord__Identity_op_zlze__ ;
         GHC.Base.op_zg____ := Ord__Identity_op_zg__ ;
         GHC.Base.op_zgze____ := Ord__Identity_op_zgze__ ;
         GHC.Base.compare__ := Ord__Identity_compare ;
         GHC.Base.max__ := Ord__Identity_max ;
         GHC.Base.min__ := Ord__Identity_min |}.

(* Translating `instance Enum__Identity' failed: OOPS! Cannot find information
   for class Qualified "GHC.Enum" "Enum" unsupported *)

(* Translating `instance Bounded__Identity' failed: OOPS! Cannot find
   information for class Qualified "GHC.Enum" "Bounded" unsupported *)

(* Translating `instance Bits__Identity' failed: OOPS! Cannot find information
   for class Qualified "Data.Bits" "Bits" unsupported *)

(* External variables:
     bool comparison cons false list nil Coq.Program.Basics.compose
     Data.Foldable.Foldable GHC.Base.Applicative GHC.Base.Eq_ GHC.Base.Functor
     GHC.Base.Monad GHC.Base.Monoid GHC.Base.Ord GHC.Base.Semigroup GHC.Base.compare
     GHC.Base.const GHC.Base.fmap GHC.Base.id GHC.Base.mappend GHC.Base.max
     GHC.Base.mconcat GHC.Base.mempty GHC.Base.min GHC.Base.op_z2218U__
     GHC.Base.op_zeze__ GHC.Base.op_zg__ GHC.Base.op_zgze__ GHC.Base.op_zl__
     GHC.Base.op_zlze__ GHC.Base.op_zlzlzgzg__ GHC.Base.op_zsze__ GHC.Base.op_ztzg__
     GHC.Base.pure GHC.Num.Int GHC.Num.Num GHC.Num.fromInteger GHC.Prim.coerce
*)
