{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}

module OpenSkill.Models.ThurstoneMostellerFull
  ( ThurstoneMostellerFull (..),
    thurstoneMostellerFull,
  )
where

import Data.Number.Erf (Erf (erf))
import OpenSkill.Types
  ( Distribution (..),
    Model (..),
    Options (..),
    Rating (..),
    Team,
  )
import OpenSkill.Utils
  ( defaultOptions,
    update,
  )

thurstoneMostellerFull :: ThurstoneMostellerFull
thurstoneMostellerFull = ThurstoneMostellerFull defaultOptions

newtype ThurstoneMostellerFull = ThurstoneMostellerFull {options :: Options}

instance Model ThurstoneMostellerFull where
  newRating :: ThurstoneMostellerFull -> Rating
  newRating self = Rating (muI $ options self) (sigmaI $ options self)

  rate :: ThurstoneMostellerFull -> [Team] -> [Team]
  rate self teams = zipWith (curry rateTeam) [0 ..] teams
    where
      beta' = beta $ options self
      epsilon' = epsilon $ options self
      kappa' = kappa $ options self

      rateTeam :: (Int, Team) -> Team
      rateTeam (i, teamI) = map ratePlayer teamI
        where
          ratingI = sumd teamI
          filteredTeams = filter (\(q, _) -> q /= i) (zip [0 ..] teams)
          omegaI = foldl calcOmegaI 0 filteredTeams
          deltaI = foldl calcDeltaI 0 filteredTeams

          calcOmegaI :: Double -> (Int, Team) -> Double
          calcOmegaI acc (q, teamQ) = acc + (sigma ratingI ** 2 / cIQ) * (s * v x t)
            where
              ratingQ = sumd teamQ
              cIQ = sqrt (sigma ratingI ** 2 + sigma ratingQ ** 2 + 2 * beta' ** 2)
              x = (mu ratingI - mu ratingQ) / cIQ
              t = epsilon' / cIQ
              s = if q > i then 1 else -1

          calcDeltaI :: Double -> (Int, Team) -> Double
          calcDeltaI acc (q, teamQ) = acc + (sigma ratingI / cIQ) ** 2 * (s * w x t)
            where
              ratingQ = sumd teamQ
              cIQ = sqrt (sigma ratingI ** 2 + sigma ratingQ ** 2 + 2 * beta' ** 2)
              x = (mu ratingI - mu ratingQ) / cIQ
              t = epsilon' / cIQ
              s = if q > i then 1 else -1

          ratePlayer :: Rating -> Rating
          ratePlayer ratingIJ = update ratingIJ ratingI omegaI deltaI kappa'

pdf :: Double -> Double
pdf x = exp (negate $ x ^ 2) / sqrt (2 * pi)

cdf :: Double -> Double
cdf x = (1 + erf (x / sqrt 2)) / 2

v :: Double -> Double -> Double
v x t = pdf (x - t) / cdf (x - t)

w :: Double -> Double -> Double
w x t = v x t * (v x t + x - t)
