{-# LANGUAGE DeriveGeneric #-}

module Openskill.Models.PlackettLuce where

import GHC.Generics
import Openskill.Types

data PlackettLuce = PlackettLuce
  { distribution :: Distribution,
    initialRating :: Rating
  }
  deriving (Show, Generic)

instance Model PlackettLuce where
  newRating = initialRating

  rate _ _ _ = error "NotImplementedError"

  winProbability _ _ = error "NotImplementedError"
