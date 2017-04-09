import Html exposing (..)
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- model

type alias Model =
  { counter : Int
  }

model : Model
model = 
  { counter = 0
  }
  
-- update

type Msg = Increment | Reset

update : Msg -> Model -> Model
update msg model = case msg of
  Increment -> { model | counter = model.counter + 1 }
  Reset -> { model | counter = 0 }
  
-- view

view : Model -> Html Msg
view model = div []
  [ h1 [] [ text "Toller Zähler" ]
  , div [] 
    [ span [] [ text "aktueller Stand: " ]
    , span [] [ text <| toString model.counter ]
    ]
  , button [ onClick Increment ] [ text "+" ]
  , button [ onClick Reset ] [ text "Reset!" ]
  ]