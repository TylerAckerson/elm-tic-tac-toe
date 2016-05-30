module TTT exposing (main)

import Position
import Html exposing (Html, button, div, text)
import Html.App as App
import Array
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)

main =
  App.beginnerProgram
    { model = init
    , view = view
    , update = update
    }

-- MODEL

type alias Model =
  { positions : List IndexedPosition
  , current : Team
  }

type alias IndexedPosition =
  { id : Int
  , pos : (Int, Int)
  , model : Position.Model
  }

type alias Team = String

  -- Model
init : Model
init =
  { positions =
    [ IndexedPosition 0 (0, 0) (Position.init "_")
    , IndexedPosition 1 (0, 1) (Position.init "_")
    , IndexedPosition 2 (0, 2) (Position.init "_")
    , IndexedPosition 3 (1, 0) (Position.init "_")
    , IndexedPosition 4 (1, 1) (Position.init "_")
    , IndexedPosition 5 (1, 2) (Position.init "_")
    , IndexedPosition 6 (2, 0) (Position.init "_")
    , IndexedPosition 7 (2, 1) (Position.init "_")
    , IndexedPosition 8 (2, 2) (Position.init "_")
    ]
  , current = "X"
  }


-- UPDATE

type Msg
  = Reset
  | Select Int Position.Msg
  | NoOp Position.Msg

update : Msg -> Model -> Model
update msg model =
  case msg of

    Reset ->
      init

    Select id msg ->
      { model
        | positions = List.map (updateHelp id model.current msg) model.positions
        , current = (if model.current == "X" then "O" else "X")
      }

    NoOp msg ->
      model

updateHelp : Int -> Team -> Position.Msg -> IndexedPosition -> IndexedPosition
updateHelp targetId player msg {id, pos, model}  =
  IndexedPosition id pos (if targetId == id then Position.update msg player model else model)

-- VIEW

view : Model -> Html Msg
view model =
  let
    positions = List.map viewIndexedPosition model.positions
  in
    div [ id "tic-tac-toe" ]
      [ div [ class "current" ] [ text "Current player: " ]
      , div [ class "player" ] [ text model.current ]
      , div [ class "board"]
        ( positions )
      , button [ onClick Reset ] [ text "RESET" ]
      ]

viewIndexedPosition : IndexedPosition -> Html Msg
viewIndexedPosition {id, pos, model} =
  App.map (if model == "_" then Select id else NoOp) (Position.view model)
