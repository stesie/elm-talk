---
title: Introduction to Elm
separator: <!--s-->
verticalSeparator: <!--v-->
---
# Introduction to Elm

Stefan Siegl (<stefan.siegl@mayflower.de>)

Note:

Who of you has already used ..?

* Elm?
* React & Redux?
* Typescript?
* Haskell?

<!--s-->
# What's Elm?

* functional programming language
* focus on SPAs & components
* compiles to JavaScript code
* relatively young: 2012 by Evan Czaplicki
* focus on simplicity
* focus on reactivity

Note:

* Evan Czaplicki developed Elm for his PhD thesis

<!--v-->
# Who's using it?

* Prezi
* NoRedInk
* Microsoft
* Mozilla
* CircuitHub
...?

Note:

* Evan was employed at Prezi beginning in 2013 and is with NoRedInk since 2016
* Richard Feldman also works at NoRedInk
* current version is 0.18

<!--v-->
# Why Elm?

* very friendly & helpful compiler
* no more *undefined is not a function*
* good performance
* easily testable

<!--v-->
## What is Elm like?

* (purely) functional
* statically typed
* immutable data structures
* syntax of ML/Haskell
* package repo, enforcing semver

<!--v-->
## Haskell!? gotta leave ...

Nope! Elm strives for simplicity and easy entry

* no "higher kinded types"
* no "type classes"
* no overloaded functions
* clearer syntax
* eager evaluation

<!--s-->
# Compiler? Helpful!?

<!--v-->

<div style="display: block; white-space: pre; padding: 2em; text-align: left; font-size: 50%; font-family: monospace">Detected errors in 1 module.
<span style="color: rgb(0, 168, 198);">

-- NAMING ERROR ----------------------------------------------------------------</span>
<span style="color: rgb(213, 32, 12);"></span>
Cannot find variable `List.fold`.
<span style="color: rgb(213, 32, 12);"></span>
<span style="color: rgb(154, 154, 154);">7|</span> <span style="color: rgb(154, 154, 154);">sum = List.fold (+) 0</span>
<span style="color: rgb(213, 32, 12);">         ^^^^^^^^^</span>
`List` does not expose `fold`. Maybe you want one of the following?
<span style="color: rgb(213, 32, 12);"></span>
<span style="color: rgb(154, 154, 154);">    List.foldl</span>
<span style="color: rgb(154, 154, 154);">    List.foldr</span>
<span style="color: rgb(213, 32, 12);"></span>
<span style="color: rgb(213, 32, 12);"></span>
</div>

Note:

The compiler makes suggestions for typos, what you might have meant ...

<!--v-->

<div style="display: block; white-space: pre; padding: 2em; text-align: left; font-size: 50%; font-family: monospace">Detected errors in 1 module.
<span style="color: rgb(0, 168, 198);">

-- TYPE MISMATCH ---------------------------------------------------------------</span>
<span style="color: rgb(213, 32, 12);"></span>
The 3rd argument to function `foldl` is causing a mismatch.
<span style="color: rgb(213, 32, 12);"></span>
<span style="color: rgb(154, 154, 154);">8|</span> <span style="color: rgb(154, 154, 154);">      List.foldl (+) 0 strings</span>
<span style="color: rgb(213, 32, 12);">                          ^^^^^^^</span>
Function `foldl` is expecting the 3rd argument to be:
<span style="color: rgb(213, 32, 12);"></span>
<span style="color: rgb(154, 154, 154);">    List number</span>
<span style="color: rgb(213, 32, 12);"></span>
But it is:
<span style="color: rgb(213, 32, 12);"></span>
<span style="color: rgb(154, 154, 154);">    List String</span>
<span style="color: rgb(213, 32, 12);"></span>
<u>Hint:</u> I always figure out the type of arguments from left to right. If an
argument is acceptable when I check it, I assume it is "correct" in subsequent
checks. So the problem may actually be in how previous arguments interact with
the 3rd.
<span style="color: rgb(213, 32, 12);"></span>
<span style="color: rgb(213, 32, 12);"></span>
</div>

Note:

* for typ mismatches it shows what type was expected (and why) and what you actually provided
* compiler is speaking of itself in 1st person form :-)

<!--v-->

<div style="display: block; white-space: pre; padding: 2em; text-align: left; font-size: 50%; font-family: monospace">Detected errors in 1 module.
<span style="color: rgb(0, 168, 198);">

-- MISSING PATTERNS ------------------------------------------------------------</span>
<span style="color: rgb(213, 32, 12);"></span>
This `case` does not have branches for all possibilities.
<span style="color: rgb(213, 32, 12);"></span>
<span style="color: rgb(154, 154, 154);">5|</span><span style="color: rgb(213, 32, 12);">&gt;</span><span style="color: rgb(154, 154, 154);">        case x of</span>
<span style="color: rgb(154, 154, 154);">6|</span><span style="color: rgb(213, 32, 12);">&gt;</span><span style="color: rgb(154, 154, 154);">  Just y -&gt; y</span>
<span style="color: rgb(213, 32, 12);"></span>
You need to account for the following values:
<span style="color: rgb(213, 32, 12);"></span>
<span style="color: rgb(154, 154, 154);">    Maybe.Nothing</span>
<span style="color: rgb(213, 32, 12);"></span>
Add a branch to cover this pattern!
<span style="color: rgb(213, 32, 12);"></span>
If you are seeing this error for the first time, check out these hints:
&lt;https://github.com/elm-lang/elm-compiler/blob/0.18.0/hints/missing-patterns.md&gt;
The recommendations about wildcard patterns and `Debug.crash` are important!
<span style="color: rgb(213, 32, 12);"></span>
<span style="color: rgb(213, 32, 12);"></span>
</div>

Note:

The compiler enforces that all functions are total.  If compiler notices, that
e.g. a error branch wasn't implemented, then it bails out during compilation
(and not at runtime).

<!--v-->

* all functions are total
* no try/catch constructs
* ... this also is true for the standard library

```elm
List.head : List a -> Maybe.Maybe a
```

```elm
List.head []
-- Nothing

List.head [23, 42]
-- Just 23
```

Note:

* the whole standard library is built in a way that doesn't need exceptions
* instead it returns `Maybe` or `Result` types
* `Result` has two constructors, one for errors and one for okayish


<!--s-->

Syntax ist ja schön und gut ...

# aber so richtig jetzt!?

<!--v-->
## Hello World!

```elm
import Html exposing (..)

main = h1 [] [ text "Hello World" ]
```

<!--s-->
## Seiteneffekte FTW

* Elm ist *purely functional*
* ... und der Code, den man schreibt, ist das auch
* alle Seiteneffekte passieren in der Runtime (!!)

<!--v-->
## die Elm-Architektur

ein einfaches Programm stellt drei Funktionen bereit:

```elm
model : Model

update : Msg -> Model -> Model

view : Model -> Html Msg
```

... und definiert die Typen `Model` und `Msg`

<!--s-->
# Beispiel

einfacher Counter mit Reset

<!--v-->

```elm
-- model

type alias Model =
  { counter : Int
  }

model : Model
model =
  { counter = 0
  }
```  

<!--v-->

```elm
-- update

type Msg = Increment | Reset

update : Msg -> Model -> Model
update msg model = case msg of
  Increment -> { model | counter = model.counter + 1 }
  Reset -> { model | counter = 0 }
```

<!--v-->

```elm
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
```

<!--s-->
# Commands & Subscriptions

* Command: der Elm-Code soll initial oder "on update" mit der Außenwelt interagieren
* Subscription: auf Seiteneffekte von außen reagieren
  * Zeit (tick every ...)
  * eingehende WebSocket Nachrichten

<!--v-->
## Commands

* Beispiele: Random, HTTP Requests, WebSocket Verbindung + Nachrichten senden
* Methoden `init` und `update` geben nicht mehr nur Model zurück,
  sondern zusätzlich ein Kommando

<!--s-->
# Beispiel

Darzustellende Liste von extern per XmlHttpRequest beziehen

<!--v-->
## Aufbau JSON-Struktur

```json
{
  "resource": [
    {
      "id": 1,
      "name": "Management"
    },
    {
      "id": 2,
      "name": "Team"
    },
    {
      "id": 3,
      "name": "Product Owner"
    },
    {
      "id": 4,
      "name": "Scrum Master"
    },
    {
      "id": 5,
      "name": "Prozess"
    }
  ]
}
```

<!--v-->
## Step 0: Model

```elm
-- model

type alias Model =
  { categories : Maybe (List String)
  }
```

<!--v-->
## Step 1: Update

```
-- update
type Msg = NewData (Result Http.Error (List String))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = case msg of
  NewData (Err _) -> (model, Cmd.none)
  NewData (Ok newCategories)
    -> (Model <| Just newCategories, Cmd.none)
```

<!--v-->
## Step 2: type-safe JSON

JSON Struktur muss in type-safe Welt übertragen werden, dazu wird ein Decoder verwendet:

```elm
import Json.Decode as Decode

decodeCategoryList: Decode.Decoder (List String)
decodeCategoryList =
  Decode.field "resource"
    <| Decode.list
    <| Decode.field "name" Decode.string
```

<!--v-->
## Step 3: Command erzeugen

... dieser Decoder kann dann verwendet werden, um einen HTTP Request zu senden
und die Response zu decodieren:

```elm
fetchCategoryList: Cmd Msg
fetchCategoryList =
  decodeCategoryList
    |> Http.get "https://df.brokenpipe.de/api/v2/db/_table/category?api_key=..."
    |> Http.send NewData
```

<!--v-->
## Step 4: Feuer frei!

```elm
init : (Model, Cmd Msg)
init =
  (Model Nothing, fetchCategoryList)
```

<!--s-->
# Resourcen

* https://guide.elm-lang.org/
* https://www.elm-tutorial.org/en/

* http://package.elm-lang.org/

<!--v-->
# Fragen?

<!--v-->

Mail: stefan.siegl@mayflower.de

Twitter: @stesie23

Slides: https://stesie.github.io/elm-talk/
