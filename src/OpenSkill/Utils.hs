{-# OPTIONS_GHC -Wno-type-defaults #-}

module OpenSkill.Utils where

import OpenSkill.Types (Distribution (sumd), Strength (..), Team)

standardizedQuantity :: Strength -> Strength -> Double
standardizedQuantity theta prior = (mu' theta - mu' prior) / sigma' prior

ordinal :: Strength -> Double
ordinal theta = mu' theta - 3 * sigma' theta

update :: Double -> Double -> Double -> Strength -> Team -> Strength
update omega delta kappa theta_j theta_js = Strength mu sigma
  where
    theta = sumd theta_js
    mu = mu' theta_j + mu' theta + sigma' theta_j ^ 2 / sigma' theta * omega
    sigma = sqrt $ sigma' theta_j ^ 2 * max (1 - sigma' theta_j ^ 2 / sigma' theta ^ 2 * delta) kappa
