module Main exposing (main)

import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Svg exposing (svg)
import Svg.Attributes as S exposing (fontFamily, fontSize, rotate, stroke, strokeWidth, textAnchor, viewBox, x, x1, x2, y, y1, y2)


main : Html msg
main =
    div
        [ style "transform" "rotateX(180deg)"
        ]
        [ div
            []
            [ rangeScale
            ]
        , div
            []
            [ abScales
            ]
        ]


htmlBoxHeight =
    "180px"


viewBoxHeight =
    String.fromInt <| 2 * ruleHalfWidthSVG


viewBoxMinY =
    String.fromInt <| -1 * ruleHalfWidthSVG


viewBoxActual =
    "-100 " ++ viewBoxMinY ++ " 5200 " ++ viewBoxHeight


tickSize i =
    case ( modBy 10 i, modBy 5 i ) of
        ( 0, 0 ) ->
            60

        ( _, 0 ) ->
            45

        _ ->
            30


rightEdgeLabel f spacing bigness i =
    if modBy 10 i == 0 then
        [ Svg.text_
            [ x <|
                String.fromFloat <|
                    (toFloat i * spacing)
            , y <| String.fromFloat <| ruleHalfWidthSVG - textInset
            , S.fill "black"
            , textAnchor "middle"
            , fontFamily "monospace"
            , fontSize bigness
            , rotate <| "0"
            ]
            [ Svg.text <|
                f i
            ]
        ]

    else
        []


leftEdgeLabel f spacing bigness i =
    if modBy 10 i == 0 then
        [ Svg.text_
            [ x <|
                String.fromFloat <|
                    (toFloat i * spacing)
                        + 25
            , y <| String.fromFloat <| 0 - ruleHalfWidthSVG + textInset
            , S.fill "black"
            , textAnchor "middle"
            , fontFamily "monospace"
            , fontSize bigness
            , rotate <| "180"
            ]
            [ Svg.text <|
                String.reverse <|
                    f i
            ]
        ]

    else
        []


labelWithModifier f spacing bigness i =
    if modBy 10 i == 0 then
        rightEdgeLabel f spacing bigness i
            ++ leftEdgeLabel f spacing bigness i

    else
        []


inchSpacing =
    25.4


cmSpacing =
    10.0


textInset =
    80


systemTextY =
    60


ruleHalfWidthSVG =
    250


printerScaling =
    1.0544


viewBoxWidth =
    1400.0 * printerScaling


pixelWidth =
    String.fromFloat viewBoxWidth ++ "px"


bracket left right =
    -- Each bracket is six line segments.
    -- Probably neater to use SVG path but barely worth it.
    let
        centre =
            (left + right) // 2

        notchHeight =
            15

        fromEdge =
            140

        endInset =
            5

        notchHalfWidth =
            -- Doubles as length of end droop
            5
    in
    [ Svg.line
        [ x1 <| String.fromFloat (toFloat (left + endInset) * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge + notchHeight
        , x2 <| String.fromFloat (toFloat (left + endInset + notchHalfWidth) * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (left + endInset + notchHalfWidth) * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat (centre - notchHalfWidth) * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (centre - notchHalfWidth) * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat centre * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge - notchHeight
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat centre * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge - notchHeight
        , x2 <| String.fromFloat (toFloat (centre + notchHalfWidth) * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (centre + notchHalfWidth) * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat (right - endInset - notchHalfWidth) * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (right - endInset - notchHalfWidth) * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat (right - endInset) * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleHalfWidthSVG - fromEdge + notchHeight
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    ]


tick spacing i =
    -- Decided to draw both edges for each tick.
    -- Also, center line of rule will be Y == 0.
    let
        theX =
            String.fromFloat (toFloat i * spacing)

        oneSide sign =
            Svg.line
                [ x1 theX
                , y1 <|
                    String.fromInt <|
                        sign
                            * ruleHalfWidthSVG
                , x2 theX
                , y2 <|
                    String.fromInt <|
                        sign
                            * (ruleHalfWidthSVG - tickSize i)
                , stroke "black"
                , strokeWidth "3"
                ]
                []
    in
    [ oneSide 1
    , oneSide -1
    ]


rangeScale =
    let
        labeler x =
            String.fromInt x
    in
    svg
        [ viewBox viewBoxActual
        , S.width pixelWidth
        , S.height htmlBoxHeight
        ]
    <|
        List.concatMap (tick inchSpacing) (List.range 0 200)
            ++ List.concatMap (labelWithModifier labeler inchSpacing "40") (List.range 0 190)


abScales =
    let
        labeler x =
            String.fromInt <| modBy 230 (40 + x)

        commonSystemText xPos points txt =
            [ Svg.text_
                [ x <| String.fromFloat <| (xPos * cmSpacing)
                , y <| String.fromFloat systemTextY
                , S.fill "black"
                , textAnchor "middle"
                , fontFamily "monospace"
                , fontSize points
                ]
                [ Svg.text txt
                ]
            ]

        aSystemText =
            bracket 0 190
                ++ commonSystemText 96 "40" "\"A\" SYSTEM G"
                ++ commonSystemText 111.5 "32" "⍺"

        bSystemText =
            bracket 190 320
                ++ commonSystemText 255 "40" "\"B\" SYSTEM G"
                ++ commonSystemText 270.5 "32" "⍺"
    in
    svg
        [ viewBox viewBoxActual
        , S.width pixelWidth
        , S.height htmlBoxHeight
        ]
    <|
        List.concatMap (tick cmSpacing) (List.range 0 310)
            ++ List.concatMap (rightEdgeLabel labeler cmSpacing "40") (List.range 10 310)
            ++ aSystemText
            ++ bSystemText
