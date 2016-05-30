module Position exposing (Model, Msg, init, update, view)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick, on, onSubmit)
import Html.Attributes exposing (..)


-- MODEL

type alias Model = String

init : String -> Model
init value =
  value


-- UPDATE

type Msg
  = Select

update : Msg -> String -> Model -> Model
update msg player model =
  case msg of
    Select ->
      player


-- VIEW

view : Model -> Html Msg
view model =
  div [ onClick Select, class "position" ]
   [ text model ]
