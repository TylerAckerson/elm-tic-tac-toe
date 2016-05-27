module TTT exposing (main)
import Html exposing (Html, button, div, text)
import Html.App as Html
import Html.Events exposing (onClick)
import Html.Attributes as Attr

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

-- MODEL

type alias Model =
  {
  position : String
  , teams : List Team
  }

type alias Team = String

  -- Model
model : Model
model =
  { position  = " "
  , teams = [ "X", "O" ]
  }

-- UPDATE

type Msg
  = Select
  -- | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Select ->
       { model | position = "X"  }
    --   model + 1
    --
    -- Decrement ->
    --   model - 1
--
-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--   case msg of
--     Button ->
--       ( { model | clicks = model.clicks + 1 }
--         , Cmd.none )
--     MouseMove position ->
--        ( { model | x = position.x }, Cmd.none)
--

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
      button [ onClick Select, squareStyle ] [ text  model.position ]
      ,button [ onClick Select, squareStyle ] [ text  model.position ]
      ,button [ onClick Select, squareStyle ] [ text  model.position ]
      , Html.br [] []
      ,button [ onClick Select, squareStyle ] [ text  model.position ]
      ,button [ onClick Select, squareStyle ] [ text  model.position ]
      ,button [ onClick Select, squareStyle ] [ text  model.position ]
      , Html.br [] []
      ,button [ onClick Select, squareStyle ] [ text  model.position ]
      ,button [ onClick Select, squareStyle ] [ text  model.position ]
      ,button [ onClick Select, squareStyle ] [ text  model.position ]
      ]
  ]
    -- [ button [ onClick Select ] [ text " " ]
    -- , button [ onClick Select ] [ text " " ]
    -- , button [ onClick Select ] [ text " " ]
    -- , button [ onClick Select ] [ text " " ]
    -- , button [ onClick Select ] [ text " " ]
    -- , button [ onClick Select ] [ text " " ]
    -- , button [ onClick Select ] [ text " " ]
    -- , button [ onClick Select ] [ text " " ]
    -- , button [ onClick Select ] [ text " " ]


-- styles
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
