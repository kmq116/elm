module Type exposing (..)

import Debug exposing (toString)
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String exposing (..)



-- init 初始化数据 update 操作数据 view 视图层
-- MODEL


type alias Model =
    { content : String
    }


init : Model
init =
    { content = "" }



-- UPDATE
-- change 传入一个以 String 函数


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
        , div [] [ text (reverse model.content) ]
        , div [] [ text (toString (length model.content)) ]
        ]



