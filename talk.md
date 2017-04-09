---
title: Introduction to Elm
separator: <!--s-->
verticalSeparator: <!--v-->
theme: white
highlightTheme: solarized-light
---
# Introduction to Elm

Stefan Siegl (<stefan.siegl@mayflower.de>)

<!--s-->
# Wer hat schon einmal was mit ... gemacht?

* React & Redux?
* Typescript?
* Haskell?

<!--s-->
# Was ist Elm?

* eine Programmiersprache, speziell (nur) für JavaScript Frontend Applikationen
* relativ jung: 2012 von Evan Czaplicki
* kompiliert zu JavaScript Code
* Fokus auf Einfachheit
* Fokus auf Reaktivität

<!--v-->
# Warum Elm?

* sehr freundlicher, hilfsbereiter Compiler
* nie wieder *undefined is not a function*
* gute Performance

<!--v-->
## Was macht Elm aus?

* funktional
* pure functions
* statisch getyped
* immutable data structures
* Syntax von Haskell

<!--v-->
## Haskell!?  ich muss weg ...

Nope! Elm will einfach sein, und ist es auch

* keine "higher kinded types"
* keine "type classes"
* kein Überladen von Funktionen
* eager evaluation

<!--s-->
# Compiler? Hilfsbereit!?

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

<!--s-->
# Syntax

## Kommentare

```elm
-- einzelne Zeile

{-
   mehrzeilig
-}
```

<!--v-->
## Rechenoperationen

```elm
2 + 3
2 - 3
2 * 3
2 / 3   -- float
2 // 3  -- int
2 % 3   -- modulo
2 ^ 3
```

<!--s-->
# Datentypen

## Literale
```elm
True : Bool
False : Bool

42 : number -- Typ für Int oder Float
3.14 : Float

'a' : Char
"foo" : String

"""
multi line
string with quotes "
"""
```

<!--v-->
## Listen

der Haskell-Doppelpunkt wurde in Elm verdoppelt :-)

```elm
-- alle gleichbedeutend, Typ: List number
[ 1, 2, 3 ]

1 :: [ 2, 3 ]

1 :: 2 :: [ 3 ]

1 :: 2 :: 3 :: []
```

<!--v-->
## Tuple

```elm
(2, 3)

-- auch verschiedene Typen
foo = (23, "foo")

getText x = case x of
  (_, x) -> x
-- <function> : ( a, b ) -> b

getText foo
-- "foo" : String

-- das Selbe in grün
getText2 (_, x) = x

-- prefix notation
(,,,) 2 "foo" 5 "bar"
```

<!--v-->
## Records

```elm
p = { x = 2, y = 4 }

p.x
-- 2 : number

.x p
-- 2 : number

List.map .x [p]
-- [2] : List number

p2 = { p | x = 5 }
-- { x = 5, y = 4 }
```

<!--v-->
## Funktionen

```elm
-- named function

incr2 : Int -> Int
incr2 x = x + 2

-- anonymous

incr2 = (\x -> x + 2)

incr2 3
-- 5 : number
```

<!--v-->
## Partial Function Application

```elm
add : Int -> Int -> Int
add x y = x + y

add5 = add 5
-- <function> : number -> number

add5 7
-- 12 : number

mul : Int -> Int -> Int
mul x y = x * y

add 5 (mul 2 2)
-- 9 : number
```

<!--v-->
## Pipe Operator

... so wie in F#

```elm
add 5 (mul 2 2)
add 5 <| mul 2 2
mul 2 2 |> add 5
```

Äquivalent in Haskell: *Dollar Operator*

```haskell
add 5 $ mul 2 2
```

<!--v-->
## Function Composition

```elm
-- > (>>)
-- <function> : (a -> b) -> (b -> c) -> a -> c

add2 = (+) 2
mul2 = (*) 2

(add2 >> mul2) 2
-- 8 : number

(mul2 >> add2) 2
-- 6 : number
```

Äquivalent in der Gegenrichtung

```elm
-- > (<<)
-- <function> : (b -> c) -> (a -> b) -> a -> c
```


<!--s-->
# Algebraic Data Types

```elm
type MyMaybe a = MyJust a | MyNothing

foo = MyJust 5
-- MyJust 5 : MyMaybe number

extract foo = case foo of
  MyMaybe x -> x
  MyNothing -> 23

extract foo
-- 5 : number

extract MyNothing
-- 23 : number
```

<!--v-->
## type alias

```elm
type alias Point = { x: Int, y: Int }

p1 = Point 2 3
p2 = Point 2 3

p1 == p2
-- True : Bool
```

*aber*: Vergleich geht immer auf die Datenstruktur, kann auch nicht überschreiben werden!

<!--v-->
## keine Type Classes!

Ausweg: equality selbst implementieren und `eq` nennen
```elm
eq : Point -> Point -> Bool
eq x y = x.x == y.x

eq p1 p2
-- True : Bool
```

... und dann nicht global, sondern "namespaced"

* das Gleiche gilt für `filter`, `map` et al

```elm
List.filter (\x -> x % 2 == 0) [ 1, 2, 3, 4 ]
-- [2,4] : List Int
```

<!--s-->

Syntax ist ja schön und gut ...

# aber so richtig jetzt!?

<!--v-->
## Hello World!

```elm
import Html exposing (..)

main = h1 [] [ text "Hello World" ]
```

<!--v-->
## Seiteneffekte FTW

* Elm ist *purely functional*
* ... und der Code, den man schreibt, ist das auch
* alle Seiteneffekte passieren in der Runtime (!!)

<!--v-->
## die Elm-Architektur

ein einfaches Programm (Html.beginnerProgram) stellt drei Methoden bereit:

* model : Model
* update : Msg -> Model -> Model
* view : Model -> Html Msg

... und definiert die Typen *Model* und *Msg*

*main* sieht dann einfach so aus:

```elm
main =
  Html.beginnerProgram { model = model, view = view, update = update }
```

<!--v-->
## XmlHttpRequest

* aus `Html.beginnerProgram` wird `Html.program`
* *init* und *update* erhalten den Rückgabetyp `(Model, Cmd Msg)`
* neben einem neuen Model können sie also einen Befehl absetzen (den die Runtime dann umsetzt)
* zum Zerlegen von Results (z.B. JSON) gibt es dann verschiedene Decoder (die Typsicherheit zur Laufzeit gewährleisten)

<!--v-->

Request senden

```elm
type Msg = HandleResult (Result Http.Error String)
Decode.at ["data", "image_url"] Decode.string
  |> Http.getString "https://api.giphy.com/..." 
  |> Http.send HandleResult
```
Result verarbeiten

```elm
update msg model =
  case msg of
    HandleResult (Ok content) -> ...
    HandleResult (Err _) -> ...
```

Beispiel: http://elm-lang.org/examples/http

<!--s-->
# Resourcen

* https://guide.elm-lang.org/
* https://www.elm-tutorial.org/en/

* http://package.elm-lang.org/
