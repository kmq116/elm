module CounterList exposing (..)

import Browser
import Counter
import Html exposing (..)
import Html.Events exposing (onClick)



-- 基础数据类型


type alias Model =
    { uid : Int
    , counters : List IndexCounter
    }



--  counter 索引类型


type alias IndexCounter =
    { id : Int
    , counter : Counter.Model
    }


initModel : Model
initModel =
    { uid = 0, counters = [ { id = 0, counter = Counter.init } ] }


type Msg
    = Insert
    | Remove
    | Modify Int Counter.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Insert ->
            -- id +1 返回到新数据中
            let
                id =
                    model.uid + 1
            in
            { uid = id
            , counters = model.counters ++ [ { id = id, counter = Counter.init } ]
            }

        Remove ->
            -- 数组中直接删除 counters 中的元素
            { model | counters = List.drop 1 model.counters }

        Modify id counterMsg ->
            let
                counterMapper =
                    updateCounter id counterMsg
            in
            { model | counters = List.map counterMapper model.counters }



-- 传递索引值返回


updateCounter : Int -> Counter.Msg -> IndexCounter -> IndexCounter
updateCounter id counterMsg indexCounter =
    if id == indexCounter.id then
        { indexCounter | counter = Counter.update counterMsg indexCounter.counter }

    else
        indexCounter


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Insert ] [ text "Insert" ]
        , button [ onClick Remove ] [ text "Remove" ]
        , div [] (List.map showCounter model.counters)
        ]


showCounter : IndexCounter -> Html Msg
showCounter ({ id, counter } as indexCounter) =
    Html.map (\counterMsg -> Modify id counterMsg) (Counter.view counter)
