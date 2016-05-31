module TTT exposing (main)

import Position
import Html exposing (Html, button, div, text)
import Html.App as App
import Array exposing (..)
import List exposing (..)
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
  , gameOver : Bool
  }

type alias IndexedPosition =
  { id : Int
  , pos : (Int, Int)
  , model : Position.Model
  }

type alias Team = String
type alias Coord = (Int, Int)

  -- Model
init : Model
init =
  { positions = List.map (modelHelp) [0..8]
  , current = "X"
  , gameOver = False
  }

modelHelp : Int -> IndexedPosition
modelHelp id =
  IndexedPosition id (coordHelp id) (Position.init "_")

coordHelp : Int -> Coord
coordHelp id = -- TODO: this isn't pretty. look into modulo
  ((id // 3), (rem id 3))


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
        , gameOver = isGameOver model
      }

    NoOp msg ->
      model

updateHelp : Int -> Team -> Position.Msg -> IndexedPosition -> IndexedPosition
updateHelp targetId player msg {id, pos, model}  =
  IndexedPosition id pos (if targetId == id then Position.update msg player model else model)

isGameOver : Model -> Bool
isGameOver model =
  if (checkRows model || checkColumns model || checkCrosses model) then True else False

checkRows : Model -> Bool
checkRows model =
  let top = take 3 model.positions
      mid = drop 3 <| take 6 model.positions
      bottom = drop 3 model.positions
  in
    if
      (all (\x -> x.model == "X") top || all (\x -> x.model == "O") top)
      then True
    else if
      (all (\x -> x.model == "X") mid || all (\x -> x.model == "O") mid)
      then True
    else if
      (all (\x -> x.model == "X") bottom || all (\x -> x.model == "O") bottom)
      then True
    else
      False

checkColumns : Model -> Bool
checkColumns model =
  let left = List.filter (\x -> rem x.id 3 == 0) model.positions
      mid = List.filter (\x -> rem x.id 3 == 1) model.positions
      right = List.filter (\x -> rem x.id 3 == 2) model.positions
  in
    if
      (all (\x -> x.model == "X") left || all (\x -> x.model == "O") left)
      then True
    else if
      (all (\x -> x.model == "X") mid || all (\x -> x.model == "O") mid)
      then True
    else if
      (all (\x -> x.model == "X") right || all (\x -> x.model == "O") right)
      then True
    else
      False

checkCrosses : Model -> Bool
checkCrosses model =
    let leftToRight = List.filter (\x -> x.id == 0 || x.id == 4 || x.id == 8) model.positions
        rightToLeft = List.filter (\x -> x.id == 2 || x.id == 4 || x.id == 6) model.positions
    in
      if
        (all (\x -> x.model == "X") leftToRight || all (\x -> x.model == "O") leftToRight)
        then True
      else if
        (all (\x -> x.model == "X") rightToLeft || all (\x -> x.model == "O") rightToLeft)
        then True
      else
        False


-- VIEW

view : Model -> Html Msg
view model =
  let
    positions = List.map viewIndexedPosition model.positions
  in
    div [ id "tic-tac-toe", classList [ ( "game-over", model.gameOver == True ) ] ]
      [ div [ class "current" ] [ text "Current player: " ]
      , div [ class "player" ] [ text model.current ]
      , div [ class "board"]
        ( positions )
      , div [ classList [ ( "hidden", model.gameOver == False ), ("game-over", model.gameOver == True) ]] [ text "Game over!" ]
      , button [ onClick Reset, classList [ ( "hidden", model.gameOver == False ) ] ] [ text "Play again?" ]
      ]

viewIndexedPosition : IndexedPosition -> Html Msg
viewIndexedPosition {id, pos, model} =
  App.map (if model == "_" then Select id else NoOp) (Position.view model)
