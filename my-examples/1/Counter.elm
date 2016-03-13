module Counter where

import Html exposing (..)
import Html.Events exposing (..)

-- MODEL
type alias Model =
  Int


initModel : Model
initModel =
  0


-- UPDATE
type Action
  = NoOp
  | Increment
  | Decrement


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    Increment ->
      model + 1

    Decrement ->
      model - 1


-- VIEW
view : Signal.Address Action -> Model -> Html
view address model =
  div []
  [ button [ onClick address Decrement ] [ text "-" ]
  , span [] [ text (toString model) ]
  , button [ onClick address Increment ] [ text "+" ]
  ]
