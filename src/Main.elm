module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


type Msg
    = Increment
    | Decrement
    | Reset
    | AddTenStep


main : Program () Int Msg
main =
    Browser.sandbox { init = 0, update = update, view = view }


update : Msg -> number -> number
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Reset ->
            0

        AddTenStep ->
            model + 10


view : Int -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Reset ] [ text "reset" ]
        , button [ onClick AddTenStep ] [ text "+10" ]
        ]