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
        [ viewBox "-100 -10 4100 200"
        , S.width "600px"
        , S.height "100px"
        ]
        rangeTicks


rangeTicks =
    let
        tickSize i =
            case ( modBy 10 i, modBy 5 i ) of
                ( 0, 0 ) ->
                    60

                ( _, 0 ) ->
                    45

                _ ->
                    30

        label i =
            if i < 200 && modBy 10 i == 0 then
                [ Svg.text_
                    [ x (String.fromFloat   (toFloat i * 20))
                    , y "-100"
                    , S.fill "black"
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
                , y2 <| String.fromInt <| 0 - tickSize i
                , stroke "black"
                , strokeWidth "6"
                ]
                []
            ]
                ++ label i
    in
    List.concatMap tick (List.range 0 200)
