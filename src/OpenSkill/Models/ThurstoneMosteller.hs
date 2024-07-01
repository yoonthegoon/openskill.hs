{-# LANGUAGE DeriveGeneric #-}

module Openskill.Models.ThurstoneMosteller where

import GHC.Generics
import OpenSkill.Types

data ThurstoneMosteller = ThurstoneMosteller
  { distribution :: Distribution,
    initialRating :: Rating
  }
  deriving (Show, Generic)

instance Model ThurstoneMosteller where
  newRating = initialRating

  rate _ _ _ = error "NotImplementedError"

  winProbability _ _ = error "NotImplementedError"
