module Main exposing (main)

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes as S
    exposing
        ( fontFamily
        , fontSize
        , stroke
        , strokeWidth
        , textAnchor
        , viewBox
        , x
        , x1
        , x2
        , y
        , y1
        , y2
        )


main : Html msg
main =
    svg
        [ viewBox "-5 -10 2010 200"
        , S.width "600px"
        , S.height "100px"
        ]
        rangeTicks


rangeTicks =
    let
        tickSize i =
            case ( modBy 10 i, modBy 5 i ) of
                ( 0, 0 ) ->
                    40

                ( _, 0 ) ->
                    20

                _ ->
                    10

        label i =
            if modBy 10 i == 0 then
                [ Svg.text_
                    [ x (String.fromFloat <| min 1950 <| max 15 (toFloat i * 19.7))
                    , y "100"
                    , S.fill "green"
                    , textAnchor "middle"
                    , fontFamily "monospace"
                    , fontSize "60"
                    ]
                    [ Svg.text <| String.fromInt i
                    ]
                ]

            else
                []

        tick i =
            [ Svg.line
                [ x1 <| String.fromInt (i * 20)
                , y1 "0"
                , x2 <| String.fromInt (i * 20)
                , y2 <| String.fromInt <| tickSize i
                , stroke "green"
                , strokeWidth "8"
                ]
                []
            ]
                ++ label i
    in
    List.concatMap tick (List.range 0 100)
