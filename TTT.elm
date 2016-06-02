module TTT exposing (main)

import Position
import Html exposing (Html, button, div, text)
import Html.App as App
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
    , current : Player
    , gameOver : Bool
    }


type alias IndexedPosition =
    { id : Int
    , pos : Coord
    , model : Position.Model
    }


type alias Player =
    String


type alias Coord =
    ( Int, Int )



-- Model


init : Model
init =
    { positions = map (modelHelp) [0..8]
    , current = "X"
    , gameOver = False
    }


modelHelp : Int -> IndexedPosition
modelHelp id =
    IndexedPosition id (coordHelp id) (Position.init "_")


coordHelp : Int -> Coord
coordHelp id =
    ( id // 3, rem id 3 )



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
            let
                positions =
                    map (updateHelp id model.current msg) model.positions
            in
                { model
                    | positions = positions
                    , current =
                        (if model.current == "X" then
                            "O"
                         else
                            "X"
                        )
                    , gameOver = isGameOver positions
                }

        NoOp msg ->
            model


updateHelp : Int -> Player -> Position.Msg -> IndexedPosition -> IndexedPosition
updateHelp targetId player msg { id, pos, model } =
    IndexedPosition id
        pos
        (if targetId == id then
            Position.update msg player model
         else
            model
        )


isGameOver : List IndexedPosition -> Bool
isGameOver positions =
    if (checkRows positions || checkColumns positions || checkCrosses positions) then
        True
    else
        False


checkRows : List IndexedPosition -> Bool
checkRows positions =
    let
        top =
            take 3 positions

        mid =
            drop 3 <| take 6 positions

        bottom =
            drop 6 positions
    in
        if (all (\x -> x.model == "X") top || all (\x -> x.model == "O") top) then
            True
        else if (all (\x -> x.model == "X") mid || all (\x -> x.model == "O") mid) then
            True
        else if (all (\x -> x.model == "X") bottom || all (\x -> x.model == "O") bottom) then
            True
        else
            False


checkColumns : List IndexedPosition -> Bool
checkColumns positions =
    let
        left =
            filter (\x -> rem x.id 3 == 0) positions

        mid =
            filter (\x -> rem x.id 3 == 1) positions

        right =
            filter (\x -> rem x.id 3 == 2) positions
    in
        if (all (\x -> x.model == "X") left || all (\x -> x.model == "O") left) then
            True
        else if (all (\x -> x.model == "X") mid || all (\x -> x.model == "O") mid) then
            True
        else if (all (\x -> x.model == "X") right || all (\x -> x.model == "O") right) then
            True
        else
            False


checkCrosses : List IndexedPosition -> Bool
checkCrosses positions =
    let
        leftToRight =
            filter (\x -> x.id == 0 || x.id == 4 || x.id == 8) positions

        rightToLeft =
            filter (\x -> x.id == 2 || x.id == 4 || x.id == 6) positions
    in
        if (all (\x -> x.model == "X") leftToRight || all (\x -> x.model == "O") leftToRight) then
            True
        else if (all (\x -> x.model == "X") rightToLeft || all (\x -> x.model == "O") rightToLeft) then
            True
        else
            False



-- VIEW


view : Model -> Html Msg
view model =
    let
        positions =
            map viewIndexedPosition model.positions
    in
        div
            [ id "tic-tac-toe"
            , classList
                [ ( "game-over", model.gameOver == True )
                , ( "in-progress", model.gameOver == False )
                ]
            , attribute "data-current" model.current
            ]
            [ div [ class "current" ]
                [ text "Current player: " ]
            , div [ class "player" ] [ text model.current ]
            , div [ class "board" ]
                (positions)
            , div [ classList [ ( "hidden", model.gameOver == False ), ( "game-over", model.gameOver == True ) ] ] [ text "Game over!" ]
            , button [ onClick Reset, classList [ ( "hidden", model.gameOver == False ) ] ] [ text "Play again?" ]
            ]


viewIndexedPosition : IndexedPosition -> Html Msg
viewIndexedPosition { id, pos, model } =
    App.map
        (if model == "_" then
            Select id
         else
            NoOp
        )
        (Position.view model)
