module Main where

import CountersPair as App

import Html exposing (..)


mb : Signal.Mailbox App.Action
mb =
  Signal.mailbox App.NoOp


model : Signal App.Model
model =
  Signal.foldp App.update App.initModel mb.signal


main : Signal Html
main =
  Signal.map (App.view mb.address) model
