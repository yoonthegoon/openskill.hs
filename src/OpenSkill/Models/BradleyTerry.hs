{-# LANGUAGE DeriveGeneric #-}

module Openskill.Models.BradleyTerry where

import GHC.Generics
import Openskill.Types

data BradleyTerry = BradleyTerry
  { distribution :: Distribution,
    initialRating :: Rating
  }
  deriving (Show, Generic)

instance Model BradleyTerry where
  newRating = initialRating

  rate _ _ _ = error "NotImplementedError"

  winProbability _ _ = error "NotImplementedError"
