module TTT exposing (main)

import Position
import Html exposing (Html, button, div, text)
import Html.App as App
import Array
import Html.Events exposing (onClick)
import Html.Attributes as Attr

main =
  App.beginnerProgram
    { model = init
    , view = view
    , update = update
    }

-- MODEL

type alias Model =
  { positions : List IndexedPosition
  , teams : List Team
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
    [ IndexedPosition 0 (0, 0) (Position.init " ")
    , IndexedPosition 1 (0, 1) (Position.init " ")
    , IndexedPosition 2 (0, 2) (Position.init " ")
    , IndexedPosition 3 (1, 0) (Position.init " ")
    , IndexedPosition 4 (1, 1) (Position.init " ")
    , IndexedPosition 5 (1, 2) (Position.init " ")
    , IndexedPosition 6 (2, 0) (Position.init " ")
    , IndexedPosition 7 (2, 1) (Position.init " ")
    , IndexedPosition 8 (2, 2) (Position.init " ")
    ]
  , teams = [ "X", "O" ]
  }


-- UPDATE

type Msg
  = Reset
  | Select Int Position.Msg

update : Msg -> Model -> Model
update msg model =
  case msg of

    Reset ->
      init

    Select id msg ->
      { model | positions = List.map (updateHelp id msg) model.positions }

updateHelp : Int -> Position.Msg -> IndexedPosition -> IndexedPosition
updateHelp targetId msg {id, pos, model}  =
  IndexedPosition id pos (if targetId == id then Position.update msg model else model)

-- VIEW

view : Model -> Html Msg
view model =
  div [ outerContainer ] [
    div [ teamsStyle ] [
      div [ teamStyle ] [ text "Teams: " ]
    , div [ teamStyle ] [ text "X" ]
    , div [ teamStyle ] [ text "   " ]
    , div [ teamStyle ] [ text "O" ]
    ]
  , div []
    ( List.map viewIndexedPosition model.positions )
  , button [ onClick Reset ] [ text "RESET" ]
  ]

viewIndexedPosition : IndexedPosition -> Html Msg
viewIndexedPosition {id, pos, model} =
  App.map (Select id) (Position.view model)


-- styles
outerContainer : Html.Attribute msg
outerContainer =
  Attr.style
    [ ("font-size", "20px")
    , ("font-family", "monospace")
    , ("display", "block")
    , ("width", "300px")
    , ("height", "100%")
    , ("text-align", "center")
    , ("margin", "0 auto")
    ]

teamsStyle : Html.Attribute msg
teamsStyle =
  Attr.style
    [ ("padding", "20px")
    ]

teamStyle : Html.Attribute msg
teamStyle =
  Attr.style
    [ ("display", "inline")
    ]
