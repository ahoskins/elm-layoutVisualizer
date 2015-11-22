module Visualize where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import List

-- MODEL

type Position = Static | Relative | Fixed | Absolute
type Display = Inline | Block | InlineBlock

-- list of objects
type alias Model = {
    list: List (Position, Display),
    pos: Position
}

init : Model
init = 
    {
        list =  [],
        pos =  Static
    }



-- UPDATE

type Action = Insert | Remove | ToAbsolute | ToStatic

update : Action -> Model -> Model
update action model =
    case action of
        -- append to model
        Insert -> 
            { model |
                list = List.append model.list [(model.pos, Block)]
            }

        -- remove the last element from the model
        Remove -> 
            { model | 
                list = List.take (List.length model.list - 1) model.list
            }

        ToAbsolute ->
            { model | 
                pos = Absolute
            }

        ToStatic ->
            { model | 
                pos = Static
            }

-- VIEW

-- add buttons manually, on click of each button, set the variable to a value

view : Signal.Address Action -> Model -> Html
view address model =
    -- make a div for each in model
    let els = List.map (makeElement address) model.list
        remove = button [ onClick address Remove ] [ text "Remove" ]
        insert = button [ onClick address Insert ] [ text "Add" ]
        posAbsolute = button [ onClick address ToAbsolute ] [text "Absolute"]
        posStatic = button [ onClick address ToStatic ] [text "Static"] 
    in
        div [] ([remove, insert, posAbsolute, posStatic] ++ els)

-- return a single div with a border
makeElement : Signal.Address Action -> (Position, Display) -> Html
makeElement address (pos, disp) =
    let l : List (String, String)
        l = [("border", "2px solid black"), 
            ("position", toString pos), 
            ("display", toString disp)]
    in
        div [style l] [text "hello"]

