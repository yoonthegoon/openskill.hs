{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}

module OpenSkill.Models.ThurstoneMostellerFull
  ( thurstoneMostellerFull,
    ThurstoneMostellerFull (..),
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
          (omegaI, deltaI) = foldl calc (0, 0) filteredTeams

          calc :: (Double, Double) -> (Int, Team) -> (Double, Double)
          calc (accOmega, accDelta) (q, teamQ) = (accOmega + d, accDelta + n)
            where
              ratingQ = sumd teamQ
              cIQ = sqrt (sigma ratingI ** 2 + sigma ratingQ ** 2 + 2 * beta' ** 2)
              x = (mu ratingI - mu ratingQ) / cIQ
              t = epsilon' / cIQ
              s = if q > i then 1 else -1
              d = (sigma ratingI ** 2 / cIQ) * s * v x t
              n = (sigma ratingI / cIQ) ** 2 * s * w x t

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
