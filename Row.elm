module Row exposing (Model, init, view)

import Position
import Html.App as App
import Html exposing (Html, button, div, text)


-- MODEL

type alias Model = List Position.Model

init : List -> Model
init model =
  [ Position.init
  , Position.init
  , Position.init
  ]

-- VIEW

view : Model -> Html Position.Msg
view model =
    div []
    [
      App.map (Position.view)
    ]
