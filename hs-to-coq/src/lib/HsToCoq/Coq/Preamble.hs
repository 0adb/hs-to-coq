{-|
Module      : HsToCoq.Coq.Preamble
Description : Static preamble for all hs-to-coq output
Copyright   : Copyright © 2017 Antal Spector-Zabusky, University of Pennsylvania
License     : MIT
Maintainer  : antal.b.sz@gmail.com
Stability   : experimental
-}

{-# LANGUAGE OverloadedStrings #-}

module HsToCoq.Coq.Preamble (staticPreamble) where

import Data.Text (Text, unlines)

staticPreamble :: Text
staticPreamble = Data.Text.unlines
 [ "(* Default settings (from HsToCoq.Coq.Preamble) *)"
 , ""
 , "Set Implicit Arguments."
 , "Set Maximal Implicit Insertion."
 , "Generalizable All Variables."
 , "Unset Strict Implicit."
 , "Unset Printing Implicit Defensive."
 , ""
 , "Axiom patternFailure : forall {a}, a."
 , ""
 ]
