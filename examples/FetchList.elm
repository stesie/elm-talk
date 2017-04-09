import Html exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }

-- model

type alias Model =
  { categories : Maybe (List String)
  }

init : (Model, Cmd Msg)
init =
  (Model Nothing, fetchCategoryList)

-- update

type Msg = NewData (Result Http.Error (List String))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = case msg of
  NewData (Ok newCategories) -> (Model <| Just newCategories, Cmd.none)
  NewData (Err _) -> (model, Cmd.none)

-- view

view : Model -> Html Msg
view model = div []
  [ h1 [] [ text "Kategorie-Liste" ]
  , renderCategoryList model.categories
  ]

renderCategoryList : Maybe (List String) -> Html Msg
renderCategoryList categories = case categories of
  Nothing -> span [] [ text "Daten werden geladen ..." ]
  Just xs -> List.map (\x -> li [] [text x]) xs |> ul []

-- http

fetchCategoryList: Cmd Msg
fetchCategoryList =
  decodeCategoryList
    |> Http.get "https://df.brokenpipe.de/api/v2/db/_table/category?api_key=d115b8db49336532f6ae2b09cde208e49541d6823db33a92c6dceccaabf3b5a2"
    |> Http.send NewData

decodeCategoryList: Decode.Decoder (List String)
decodeCategoryList = 
  Decode.field "resource"
    <| Decode.list
    <| Decode.field "name" Decode.string
