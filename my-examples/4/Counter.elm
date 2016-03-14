module Counter (Model, initModel, Action, update, view, viewWithRemoveButton, Context) where

import Html exposing (..)
import Html.Attributes exposing (..)
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
type alias Context =
  { actions : Signal.Address Action
  , remove : Signal.Address ()
  }


view : Signal.Address Action -> Model -> Html
view address model =
  div [ counterStyle ]
  [ button [ onClick address Decrement ] [ text "-" ]
  , span [] [ text (toString model) ]
  , button [ onClick address Increment ] [ text "+" ]
  ]


viewWithRemoveButton : Context -> Model -> Html
viewWithRemoveButton context model =
  div [ counterStyle ]
  [ button [ onClick context.actions Decrement ] [ text "-" ]
  , span [] [ text (toString model) ]
  , button [ onClick context.actions Increment ] [ text "+" ]
  , button [ onClick context.remove () ] [ text "×" ]
  ]


counterStyle : Attribute
counterStyle =
  style
    [ ("display", "inline-block")
    ]
