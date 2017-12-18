{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE DataKinds, FlexibleContexts, TemplateHaskell #-}

module Main where

import Diagrams.Prelude
import Diagrams.Backend.Rasterific.CmdLine
import Plots

import Data.Foldable
import Frames


tableTypes "Row" "src/iris.csv"

loadRows :: IO (Frame Row)
loadRows = inCoreAoS (readTable "src/iris.csv")

ukAxis :: Frame Row -> Axis B V2 Double
ukAxis rs = r2Axis &~ do
  let ys = toList (view sepalWidth <$> rs)
      gs = toList (view sepalLength <$> rs)
  linePlot' $ zip ys gs

main :: IO ()
main = do
  rs <- loadRows
  r2AxisMain $ ukAxis rs
  return ()
