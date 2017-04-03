---
title: Elm 101
separator: <!--s-->
verticalSeparator: <!--v-->
theme: white
highlightTheme: solarized-light
---
# Elm 101

Stefan Siegl (<stesie@brokenpipe.de>)

<!--s-->
# Wer hat schon einmal ...?

<!--v-->
## ... was mit React/Redux gemacht?

... Typescript?

<!--v-->
## ... was mit Haskell gemacht?

... oder Standard ML?


<!--s-->
# Was ist Elm?

* eine Programmiersprache, speziell (nur) für JavaScript Frontend Applikationen
* ... kompiliert zu JavaScript Code
* purely functional (kein Ausweg über `as any` et al)
* Belohnung: nie wieder *undefined is not a function*
* Syntax ähnlich Haskell
* Typsystem von Standard ML
* Architekturmodell wie React/Redux
* Immutable data structures
* ein sehr freundlicher/hilfsbereiter Compiler

<!--v-->

## Haskell!?  ich muss weg ...

Nope! Elm ist leichter zu lernen

* keine Applicatives, Monaden
* keine Type Classes
* kein Überladen von Funktionen
* eager evaluation

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

<!--v-->
## Datentypen

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
## Exkurs Haskell: Dollar Operator

```haskell
let add x y = x + y
let mul x y = x * y

add 5 $ mul 2 2
```

<!--v-->
## Pipe Operator

... so wie in F#

```elm
add 5 (mul 2 2)

add 5 <| mul 2 2

mul 2 2 |> add 5
```

<!--s-->
# Function Composition

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

extract = case foo of
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


