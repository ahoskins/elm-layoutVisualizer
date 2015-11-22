module Visualize where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import List

-- MODEL

type Position = Static | Relative | Fixed | Absolute
type Display = Inline | Block | InlineBlock

-- list of objects
type alias Model = List (Position, Display)



-- UPDATE

type Action = Insert | Remove

update : Action -> Model -> Model
update action model =
    case action of
        -- append to model
        Insert -> 
            List.append model [(Static, Block)]

        -- remove the last element from the model
        Remove -> 
            List.take (List.length model - 1) model



-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
    -- make a div for each in model
    let els = List.map (makeElement address) model
        remove = button [ onClick address Remove ] [ text "Remove" ]
        insert = button [ onClick address Insert ] [ text "Add" ]
    in
        div [] ([remove, insert] ++ els)

-- return a single div with a border
makeElement : Signal.Address Action -> (Position, Display) -> Html
makeElement address (pos, disp) =
    let l : List (String, String)
        l = [("border", "2px solid black"), 
            ("position", toString pos), 
            ("display", toString disp)]
    in
        div [style l] [text "hello"]

