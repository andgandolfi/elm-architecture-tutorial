module CountersPair where

import Counter
import Html exposing (..)
import Html.Events exposing (..)

-- MODEL
type alias Model =
  { first : Counter.Model
  , second : Counter.Model
  }


initModel : Model
initModel =
  { first = Counter.initModel
  , second = Counter.initModel
  }


-- UPDATE
type Action
  = NoOp
  | ResetBoth
  | FirstCounter Counter.Action
  | SecondCounter Counter.Action


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    ResetBoth ->
      initModel

    FirstCounter act ->
      { model
      | first = Counter.update act model.first }

    SecondCounter act ->
      { model
      | second = Counter.update act model.second }


-- VIEW
view : Signal.Address Action -> Model -> Html
view address model =
  div []
  [ Counter.view (Signal.forwardTo address FirstCounter) model.first
  , Counter.view (Signal.forwardTo address SecondCounter) model.second
  , button [ onClick address ResetBoth ] [ text "Reset both" ]
  ]
