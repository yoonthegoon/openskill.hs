{-# LANGUAGE InstanceSigs #-}

module OpenSkill.Models.ThurstoneMostellerFull
  ( thurstoneMostellerFull,
    ThurstoneMostellerFull (..),
  )
where

import Data.Number.Erf (Erf (erf))
import OpenSkill.Types
  ( Distribution (sumd),
    Model (..),
    Options (beta, epsilon, kappa),
    Rating (mu, sigma),
    Team,
  )
import OpenSkill.Utils
  ( defaultOptions,
    initialRating,
    update,
  )

thurstoneMostellerFull :: ThurstoneMostellerFull
thurstoneMostellerFull = ThurstoneMostellerFull defaultOptions

newtype ThurstoneMostellerFull = ThurstoneMostellerFull {options :: Options}

instance Model ThurstoneMostellerFull where
  newRating :: ThurstoneMostellerFull -> Rating
  newRating self = initialRating $ options self

  rate :: ThurstoneMostellerFull -> [Team] -> [Int] -> [Team]
  rate self teams ranks = zipWith (curry rateTeam) [0 ..] (zip teams ranks)
    where
      beta' = beta $ options self
      epsilon' = epsilon $ options self
      kappa' = kappa $ options self

      rateTeam :: (Int, (Team, Int)) -> Team
      rateTeam (i, (teamI, rankI)) = map ratePlayer teamI
        where
          ratingI = sumd teamI
          filteredTeams = filter (\(q, _) -> q /= i) (zip [0 ..] (zip teams ranks))
          (omegaI, deltaI) = foldl calc (0, 0) filteredTeams

          calc :: (Double, Double) -> (Int, (Team, Int)) -> (Double, Double)
          calc (accOmega, accDelta) (_, (teamQ, rankQ)) = (accOmega + d, accDelta + n)
            where
              ratingQ = sumd teamQ
              cIQ = sqrt (sigma ratingI ** 2 + sigma ratingQ ** 2 + 2 * beta' ** 2)
              x = (mu ratingI - mu ratingQ) / cIQ
              t = epsilon' / cIQ
              d = (sigma ratingI ** 2 / cIQ) * g
                where
                  g
                    | rankQ > rankI = v x t
                    | rankQ < rankI = -v (-x) t
                    | otherwise = v' x t
              n = (sigma ratingI / cIQ) ** 2 * h
                where
                  h
                    | rankQ > rankI = w x t
                    | rankQ < rankI = w (-x) t
                    | otherwise = w' x t

          ratePlayer :: Rating -> Rating
          ratePlayer ratingIJ = update ratingIJ ratingI omegaI deltaI kappa'

pdf :: Double -> Double
pdf x = exp (negate $ x ** 2) / sqrt (2 * pi)

cdf :: Double -> Double
cdf x = (1 + erf (x / sqrt 2)) / 2

v :: Double -> Double -> Double
v x t = pdf (x - t) / cdf (x - t)

w :: Double -> Double -> Double
w x t = v x t * (v x t + x - t)

v' :: Double -> Double -> Double
v' x t = -((pdf (t - x) - pdf (-t - x)) / (cdf (t - x) - cdf (-t - x)))

w' :: Double -> Double -> Double
w' x t = num / den + v' x t ** 2
  where
    num = (t - x) * pdf (t - x) - (-t - x) * pdf (-t - x)
    den = cdf (t - x) - cdf (-t - x)
