module TTT exposing (main)

import Row
import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)
import Html.Attributes as Attr

main =
  App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

-- MODEL

type alias Model =
  {
  position : Row.Model
  , teams : List Team
  }

type alias Team = String

  -- Model
model : Model
model =
  { position  = Row.init
  , teams = [ "X", "O" ]
  }

-- UPDATE

type Msg
  = Reset

update : Msg -> Model -> Model
update msg model =
  case msg of

    Reset ->
      init


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
  , div [] [
      div [] [
        App.map Row (Row.view model.row)
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
    -- , ("width", "50px")
    -- , ("height", "50px")
    -- , ("text-align", "center")
    -- , ("border", "1px solid cornflowerblue")
    ]

teamStyle : Html.Attribute msg
teamStyle =
  Attr.style
    [ ("display", "inline")
    -- , ("font-family", "monospace")
    -- , ("display", "inline-block")
    -- , ("width", "50px")
    -- , ("height", "50px")
    -- , ("text-align", "center")
    -- , ("border", "1px solid cornflowerblue")
    ]
