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


bracket y left right =
    let
        centre =
            (left + right) // 2

        notch =
            15
    in
    [ Svg.line
        [ x1 <| String.fromFloat (toFloat (left + 5) * cmSpacing)
        , y1 <| String.fromInt <| y + notch
        , x2 <| String.fromFloat (toFloat (left + 10) * cmSpacing)
        , y2 <| String.fromInt y
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (left + 10) * cmSpacing)
        , y1 <| String.fromInt y
        , x2 <| String.fromFloat (toFloat (centre - 5) * cmSpacing)
        , y2 <| String.fromInt y
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (centre - 5) * cmSpacing)
        , y1 <| String.fromInt y
        , x2 <| String.fromFloat (toFloat centre * cmSpacing)
        , y2 <| String.fromInt <| y - notch
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat centre * cmSpacing)
        , y1 <| String.fromInt <| y - notch
        , x2 <| String.fromFloat (toFloat (centre + 5) * cmSpacing)
        , y2 <| String.fromInt y
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (centre + 5) * cmSpacing)
        , y1 <| String.fromInt y
        , x2 <| String.fromFloat (toFloat (right - 10) * cmSpacing)
        , y2 <| String.fromInt y
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (right - 10) * cmSpacing)
        , y1 <| String.fromInt y
        , x2 <| String.fromFloat (toFloat (right - 5) * cmSpacing)
        , y2 <| String.fromInt <| y + notch
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    ]


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

        systemText xPos txt =
            [ Svg.text_
                [ x <| String.fromFloat (toFloat xPos * cmSpacing)
                , y "-180"
                , S.fill "black"
                , textAnchor "middle"
                , fontFamily "monospace"
                , fontSize "48"
                ]
                [ Svg.text txt
                ]
            ]

        aSystemText =
            bracket -140 0 190
                ++ systemText 95 "\"A\" SYSTEM G⍺"

        bSystemText =
            bracket -140 190 320
                ++ systemText 250 "\"B\" SYSTEM G⍺"
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
            ++ bSystemText
