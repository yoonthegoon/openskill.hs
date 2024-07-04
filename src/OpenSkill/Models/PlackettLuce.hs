{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}

module OpenSkill.Models.PlackettLuce
  ( plackettLuce,
    PlackettLuce (..),
  )
where

import OpenSkill.Types
  ( -- Distribution (..),
    Model (..),
    Options (..),
    Rating (..),
    Team,
  )
import OpenSkill.Utils
  ( defaultOptions,
    initialRating,
    -- update,
  )

plackettLuce :: PlackettLuce
plackettLuce = PlackettLuce defaultOptions

newtype PlackettLuce = PlackettLuce {options :: Options}

instance Model PlackettLuce where
  newRating :: PlackettLuce -> Rating
  newRating self = initialRating $ options self

  rate :: PlackettLuce -> [Team] -> [Int] -> [Team]
  rate _ _ _ = error "Not implemented"
