module Row exposing (Model, init, view)

import Position
import Html.App as App
import Html exposing (Html, button, div, text)


-- MODEL

type alias Model =
  [ Position.Model ""
  , Position.Model ""
  , Position.Model ""
  ]

init : String -> String -> Model
init first sec third =
  [ Position.init first
  , Position.init sec
  , Position.init third
  ]

-- VIEW

view : Model -> Html Msg
view model =
    div
    []
    [ App.map (Position.view model[0])
    , App.map (Position.view model[1])
    , App.map (Position.view model[2])
    ]
