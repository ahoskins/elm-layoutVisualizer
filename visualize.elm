module Visualize where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import List

-- MODEL

type Position = Static | Relative | Fixed | Absolute
type Display = Inline | Block

-- list of objects
type alias Model = {
    list: List (Position, Display),
    pos: Position,
    disp: Display
}

init : Model
init = 
    {
        list =  [],
        pos =  Static,
        disp = Block
    }



-- UPDATE

type Action = Insert | Remove | ToAbsolute | ToStatic | ToFixed | ToRelative | ToBlock | ToInline

update : Action -> Model -> Model
update action model =
    case action of
        -- append to model
        Insert -> 
            { model |
                list = List.append model.list [(model.pos, model.disp)]
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

        ToFixed ->
            { model | 
                pos = Fixed
            }

        ToRelative ->
            { model | 
                pos = Relative
            }

        ToBlock ->
             { model | 
                disp = Block
            }

        ToInline ->
             { model | 
                disp = Inline
            }


-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
    -- make a div for each in model
    let els : List Html
        els = List.map (makeElement address) model.list

        removeButton :  Html
        removeButton = button [ onClick address Remove ] [ text "Remove" ]

        insertButton : Html
        insertButton = button [ onClick address Insert ] [ text "Add" ]

        posAbsolute = button [ onClick address ToAbsolute ] [text "Absolute"]
        posStatic = button [ onClick address ToStatic ] [text "Static"] 
        posFixed = button [ onClick address ToFixed ] [text "Fixed"] 
        posRelative = button [ onClick address ToRelative ] [text "Relative"]

        dispBlock = button [ onClick address ToBlock ] [text "Block"] 
        dispInline = button [ onClick address ToInline ] [text "Inline"]

        currentPos = div [] [text ("Next Position: " ++ toString model.pos)]
        currentDisp = div [] [text ("Next Display: " ++ toString model.disp)]
    in
        div [] ([removeButton, insertButton] ++
                [posAbsolute, posStatic, posFixed, posRelative] ++
                [dispBlock, dispInline] ++
                [currentDisp, currentPos] ++
                els)

styleIt : String -> String-> List (String, String)
styleIt modelPos pos = 
    if pos == modelPos then
        List.append [] [("background-color", "lightgreen")]
    else
        []

-- return a single div with a border
makeElement : Signal.Address Action -> (Position, Display) -> Html
makeElement address (pos, disp) =
    let l : List (String, String)
        l = [("border", "2px solid black"), 
            ("position", toString pos), 
            ("display", toString disp)]
    in
        div [style l] [text "hello"]

