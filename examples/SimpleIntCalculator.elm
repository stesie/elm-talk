import Html exposing (..)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model =
  { value: Maybe Int
  , activeOperation: Operation
  , lastResult: Int
  }

model : Model
model =
  { value = Nothing
  , activeOperation = None
  , lastResult = 0
  }


-- UPDATE

type Operation = None | Plus | Minus | Multiply | Divide

type Msg = NextDigit Int | SelectedOperation Operation

update : Msg -> Model -> Model
update msg model = case msg of
  NextDigit x -> case model.value of
    Nothing -> { model | value = Just x }
    Just y -> { model | value = Just <| y * 10 + x }
  SelectedOperation op -> applyOperation model |> Model Nothing op

applyOperation : Model -> Int
applyOperation model =
  Maybe.withDefault 0 model.value
    |> getOperator model.activeOperation model.lastResult

getOperator : Operation -> (Int -> Int -> Int)
getOperator op = case op of
  None     -> (\x y -> y)
  Plus     -> (+)
  Minus    -> (-)
  Multiply -> (*)
  Divide   -> (//)


-- VIEW

view : Model -> Html Msg
view model = 
  let
    displayResult = case model.value of
      Just x -> x
      Nothing -> model.lastResult
  in div []
  [ h1 [] [ text "Einfacher Taschenrechner" ]
  , div []
    [ label [] [ text "Aktueller Wert: " ]
    , output [ value <| toString displayResult ] []
    ]
  , div [] makeDigitButtons
  , div []
    [ button [ onClick <| SelectedOperation Plus ] [ text "+" ]
    , button [ onClick <| SelectedOperation Minus ] [ text "-" ]
    , button [ onClick <| SelectedOperation Multiply ] [ text "*" ]
    , button [ onClick <| SelectedOperation Divide ] [ text "/" ]
    ]
  ]
  
makeDigitButtons : List (Html Msg)
makeDigitButtons =
  List.range 0 9
    |> List.map (\x -> button [ onClick <| NextDigit x ] [ text <| toString x ])
    
