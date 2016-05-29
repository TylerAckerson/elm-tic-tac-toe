module TTT exposing (main)

import Position
import Html exposing (Html, button, div, text)
import Html.App as App
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
  { positionOne : Position.Model
  , positionTwo : Position.Model
  , positionThree : Position.Model
  , teams : List Team
  }

type alias Team = String

  -- Model
init : Model
init =
  { positionOne = Position.init ""
  , positionTwo = Position.init ""
  , positionThree = Position.init ""
  , teams = [ "X", "O" ]
  }

-- UPDATE

type Msg
  = Reset
  | First Position.Msg
  | Second Position.Msg
  | Third Position.Msg

update : Msg -> Model -> Model
update msg model =
  case msg of

    Reset ->
      init

    First msg ->
      { model | positionOne = Position.update msg model.positionOne }

    Second msg ->
      { model | positionTwo = Position.update msg model.positionTwo }

    Third msg ->
      { model | positionThree = Position.update msg model.positionThree }

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
      [
      div []
        [ div []
          [ App.map First (Position.view model.positionOne)
          , App.map Second (Position.view model.positionTwo)
          , App.map Third (Position.view model.positionThree)
          ]
        ]
      ]
  , button [ onClick Reset ] [ text "RESET" ]
  ]


-- styles
outerContainer : Html.Attribute msg
outerContainer =
  Attr.style
    [ ("font-size", "20px")
    , ("font-family", "monospace")
    , ("display", "block")
    , ("width", "100%")
    , ("height", "100%")
    , ("text-align", "center")
    , ("border", "3px solid black")
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
