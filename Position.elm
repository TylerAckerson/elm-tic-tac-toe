module Position exposing (Model, Msg, init, update, view)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes as Attr


-- MODEL

type alias Model = String

init : String -> Model
init model =
  ""


-- UPDATE

type Msg
  = Select

update : Msg -> Model -> Model
update msg model =
  case msg of
    Select ->
      "X"


-- VIEW

view : Model -> Html Msg
view model =
  button [ onClick Select, squareStyle ] [ text model ]

squareStyle : Html.Attribute msg
squareStyle =
  Attr.style
    [ ("display", "inline-block")
    , ("width", "100px")
    , ("height", "100px")
    , ("text-align", "center")
    , ("border", "1px solid cornflowerblue")
    , ("background", "none")
    ]
