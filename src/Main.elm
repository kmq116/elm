module Main exposing (Msg(..), main, update, view)

import Browser
import CounterList
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


type Msg
    = Increment
    | Decrement
    | Reset
    | AddTenStep
    | DecrementStep


main : Program () CounterList.Model CounterList.Msg
main =
    Browser.sandbox { init = CounterList.initModel, update = CounterList.update, view = CounterList.view }


elm : String
elm =
    "elm"


sayHello : String -> String
sayHello name =
    "Hello, " ++ name ++ "!"


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

        DecrementStep ->
            model - 10



-- view 接收一个参数 model 返回 html


view : Int -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "----" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Reset ] [ text "reset" ]
        , button [ onClick AddTenStep ] [ text "+10" ]
        , button [ onClick DecrementStep ] [ text "-10" ]
        , div [] [ text (sayHello elm) ]
        , div [] (List.map (text << getAuthedUserName) users)
        ]



-- << 相当于 lodash 的 flowRight 函数 将两个函数结合执行并返回


type User
    = Anonymos
    | Authed String


getAuthedUserName : User -> String
getAuthedUserName user =
    case user of
        Anonymos ->
            ""

        Authed name ->
            name


users : List User
users =
    [ Anonymos
    , Authed "elm"
    , Authed "kmq"
    ]



-- type List a = Empty | Node a (List a)
