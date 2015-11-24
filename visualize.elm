module Visualize where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick, on)
import List
import Json.Decode as Json

------------- MODEL ---------------

type Position = Static
                | Fixed 

type Display = Inline
                | Block

-- list of elements, and store the next elements position and display
type alias Model = {
    list: List (Position, Display),
    position: Position,
    display: Display
}

init : Model
init = 
    {
        list =  [],
        position =  Static,
        display = Block
    }

------------- UPDATE ------------------

type Action = Insert
            | Remove
            | ToStatic
            | ToFixed
            | ToBlock 
            | ToInline

update : Action -> Model -> Model
update action model =
    case action of
        -- add element
        Insert -> 
            { model |
                list = List.append model.list [(model.position, model.display)]
            }

        -- remove last element
        Remove -> 
            { model | 
                list = List.take (List.length model.list - 1) model.list
            }

        ToStatic ->
            { model | 
                position = Static
            }

        ToFixed ->
            { model | 
                position = Fixed
            }

        ToBlock ->
             { model | 
                display = Block
            }

        ToInline ->
             { model | 
                display = Inline
            }

-------------- VIEW ----------------

view : Signal.Address Action -> Model -> Html
view address model =
    -- optional type annotation...definition must follow optional annotation
    let els : List Html
        els = List.map makeElement model.list
        remove = button [clicker address Remove]
                        [text "Remove"]
        insert = button [clicker address Insert,
                        style [("margin-right", "25px")]] 
                        [text "Add"]
        static = button [clicker address ToStatic, 
                        style (styleIt (toString model.position) "Static")]
                        [text "Static"] 
        fixed = button [clicker address ToFixed, 
                       style (styleIt (toString model.position) "Fixed"),
                       style [("margin-right", "25px")]]
                       [text "Fixed"] 
        block = button [clicker address ToBlock,
                       style (styleIt (toString model.display) "Block")]
                       [text "Block"] 
        inline = button [clicker address ToInline, 
                        style (styleIt (toString model.display) "Inline")]
                        [text "Inline"]
    in
        div [] ([remove, insert] ++
                [static, fixed] ++
                [block, inline] ++
                els)

-- custom clicker event handler, not needed there's a built-in onClick
clicker : Signal.Address Action -> Action -> Attribute
clicker address action =
    on "click" Json.value (\_ -> Signal.message address action)

-- color the active button green
styleIt : String -> String -> List (String, String)
styleIt modelPos position = 
    if position == modelPos then
        List.append [] [("background-color", "lightgreen")]
    else
        []

-- make a single div with a border
makeElement : (Position, Display) -> Html
makeElement (position, display) =
    -- everything is an expression, so when declaring a variable
    -- it needs to know the expression is found in the "in" block
    let l : List (String, String)
        l = [("border", "2px solid black"), 
            ("position", toString position), 
            ("display", toString display)]
    in
        div [style l] [text "Hello Elm"]

