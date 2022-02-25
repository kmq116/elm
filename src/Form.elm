module Form exposing (Model, Msg(..), init)

import Browser
import Debug exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Regex


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


init : Model
init =
    Model "" "" ""


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain passwordAgain ->
            { model | passwordAgain = passwordAgain }


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewValidation model
        ]


viewInput : String -> String -> String -> (String -> Msg) -> Html Msg
viewInput tp ph v toMsg =
    input [ type_ tp, placeholder ph, value v, onInput toMsg ] []


regex : Regex.Regex
regex =
    Maybe.withDefault Regex.never <|
        Regex.fromString "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z_]{8,16}$"


viewValidation : Model -> Html Msg
viewValidation model =
    if String.length model.password < 8 then
        div [ style "color" "red" ] [ text "Password too short" ]

    else if model.password /= model.passwordAgain then
        div [ style "color" "red" ] [ text "Passwords don't match" ]

    else if Regex.contains regex model.password == False then
        div [ style "color" "red" ] [ text "Password must contain letters and numbers" ]

    else
        div [ style "color" "green" ] [ text "OK" ]


includeFormat : String -> String
includeFormat str =
    str
