module CountersList where

import Counter
import Html exposing (..)
import Html.Events exposing (..)

-- MODEL
type alias ItemId =
  Int

type alias ItemModel =
  { counter : Counter.Model
  , id : ItemId
  }

type alias Model =
  { counters : List ItemModel
  , nextId : ItemId
  }

initModel : Model
initModel =
  { counters = []
  , nextId = 0
  }


-- UPDATE
type Action
  = NoOp
  | AddCounter
  | RemoveAll
  | RemoveCounter ItemId
  | DoCounter ItemId Counter.Action


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    AddCounter ->
      let
        newCounter =
          ItemModel Counter.initModel model.nextId
        newNextId =
          model.nextId + 1
      in
        { model
        | counters = newCounter :: model.counters
        , nextId = newNextId
        }

    RemoveAll ->
      { model
      | counters = []
      }

    RemoveCounter id ->
      { model
      | counters = List.filter (\item -> item.id /= id) model.counters
      }

    DoCounter id counterAction ->
      let
        applyAction item =
          if id == item.id then
            { item
            | counter = Counter.update counterAction item.counter
            }
          else
            item
      in
        { model
        | counters = List.map applyAction model.counters
        }


-- VIEW
itemView : Signal.Address Action -> ItemModel -> Html
itemView address model =
  div []
  [ Counter.view (Signal.forwardTo address (DoCounter model.id)) model.counter
  , button [ onClick address (RemoveCounter model.id) ] [ text "×" ]
  ]


view : Signal.Address Action -> Model -> Html
view address model =
  div []
  ( List.concat
      [ [ button [ onClick address AddCounter ] [ text "Add Counter" ] ]
      , [ button [ onClick address RemoveAll ] [ text "Remove All" ] ]
      , List.map (itemView address) model.counters
      ]
  )
