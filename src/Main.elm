module Main exposing (main)

import Html exposing (Html, div)
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
    div []
        [ rangeScale
        , abScales
        ]


tickSize i =
    case ( modBy 10 i, modBy 5 i ) of
        ( 0, 0 ) ->
            60

        ( _, 0 ) ->
            45

        _ ->
            30


label spacing i =
    if modBy 10 i == 0 then
        [ Svg.text_
            [ x <| String.fromFloat (toFloat i * spacing)
            , y "-80"
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


labelWithModifier f spacing i =
    if modBy 10 i == 0 then
        [ Svg.text_
            [ x <| String.fromFloat (toFloat i * spacing)
            , y "-80"
            , S.fill "black"
            , textAnchor "middle"
            , fontFamily "monospace"
            , fontSize "48"
            ]
            [ Svg.text <| f i
            ]
        ]

    else
        []


inchSpacing =
    25.4


cmSpacing =
    10


tick spacing i =
    [ Svg.line
        [ x1 <| String.fromFloat (toFloat i * spacing)
        , y1 "0"
        , x2 <| String.fromFloat (toFloat i * spacing)
        , y2 <| String.fromInt <| 0 - tickSize i
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    ]


rangeScale =
    svg
        [ viewBox <| "-100 -200 5200 100"
        , S.width "1400px"
        , S.height "100px"
        ]
    <|
        List.concatMap (tick inchSpacing) (List.range 0 200)
            ++ List.concatMap (label inchSpacing) (List.range 0 190)


abScales =
    let
        labeller x =
            String.fromInt <| modBy 230 (40 + x)

        aSystemText =
                   [ Svg.text_
                        [ x <| String.fromFloat (toFloat 100 * cmSpacing)
                        , y "-160"
                        , S.fill "black"
                        , textAnchor "middle"
                        , fontFamily "monospace"
                        , fontSize "48"
                        ]
                        [ Svg.text <| "A SYSTEM G⍺"
                        ]
                    ]

        bSystemText =
                   [ Svg.text_
                        [ x <| String.fromFloat (toFloat 240 * cmSpacing)
                        , y "-160"
                        , S.fill "black"
                        , textAnchor "middle"
                        , fontFamily "monospace"
                        , fontSize "48"
                        ]
                        [ Svg.text <| "B SYSTEM G⍺"
                        ]
                    ]

    in
    svg
        [ viewBox "-100 -200 5200 200"
        , S.width "1400px"
        , S.height "100px"
        ]
    <|
        List.concatMap (tick cmSpacing) (List.range 0 310)
            ++ List.concatMap (labelWithModifier labeller cmSpacing) (List.range 10 310)
            ++ aSystemText
            ++bSystemText
