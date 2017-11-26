Require Import GHC.Base.

Require Import Coq.Logic.FunctionalExtensionality.

Require Import Proofs.GHC.Base.
Require Import Data.Either.

From mathcomp Require Import ssreflect ssrfun ssrbool.
Set Bullet Behavior "Strict Subproofs".

Instance EqLaws_Either {a b} `{EqLaws a} `{EqLaws b} : EqLaws (Either a b).
Proof.
  split; repeat unfold op_zeze__, op_zsze__,
  Either.instance_forall___GHC_Base_Eq__b____GHC_Base_Eq__a___GHC_Base_Eq___Either_a_b_ ,
  Either.instance_forall___GHC_Base_Eq__b____GHC_Base_Eq__a___GHC_Base_Eq___Either_a_b__op_zeze__,
  Either.instance_forall___GHC_Base_Eq__b____GHC_Base_Eq__a___GHC_Base_Eq___Either_a_b__op_zsze__.
  - case=> ? /=; apply Eq_refl.
  - do 2 case=> ? //=; apply Eq_sym.
  - do 3 case=> ? //=; apply Eq_trans.
  - do 2 case => ? //=; admit.
Admitted.

Instance EqExact_Either {a b} `{EqExact a} `{EqExact b} : EqExact (Either a b).
Proof.
  split ;
    unfold op_zeze__, op_zsze__,
    instance_forall___GHC_Base_Eq__b____GHC_Base_Eq__a___GHC_Base_Eq___Either_a_b_ ,  op_zeze____, op_zsze____=> - [xl|xr] [yl|yr] //=; try (by constructor);
    case E: (_ == _); constructor; move/Eq_eq in E;
    by [rewrite E | contradict E; case: E].
Qed.

Instance instance_FunctorLaws_Either {a} : FunctorLaws (Either a).
Proof.
  split; repeat unfold fmap, instance_GHC_Base_Functor__Either_a_,
         Either.instance_GHC_Base_Functor__Either_a__fmap.
  - intros. destruct x. auto.
    auto.
  - intros. destruct x. auto.
    unfold "_∘_". auto.
Qed.

Instance instance_ApplicativeLaws_Either {a} : ApplicativeLaws (Either a).
Proof.
  split;
    repeat (unfold pure, instance_Applicative__Either_a_,
    Either.instance_GHC_Base_Applicative__Either_e__pure,
    Either.instance_GHC_Base_Applicative__Either_e__op_zlztzg__,
    Either.instance_GHC_Base_Functor__Either_a__fmap; simpl).
  - intros. destruct v; auto.
  - intros. destruct u; destruct v; destruct w; auto.
  - intros. auto.
  - intros. destruct u; auto.
  - by move=> ? ? f [].
Qed.

Instance instance_MonadLaws_Either {a} : MonadLaws (Either a).
Proof.
  split; intros;
   repeat (unfold pure, instance_Applicative__Either_a_,
    Either.instance_GHC_Base_Applicative__Either_e__pure,
    Either.instance_GHC_Base_Applicative__Either_e__op_zlztzg__,
    Either.instance_GHC_Base_Functor__Either_a__fmap,
    Either.instance_GHC_Base_Monad__Either_e__return_,
    instance_GHC_Base_Monad__Either_e__op_zgzgze__; simpl).
  - auto.
  - destruct m; auto.
  - destruct m; try destruct (k x); auto.
  - auto.
  - auto.
Qed.
