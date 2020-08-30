module Main exposing (main)

import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Svg exposing (svg, text)
import Svg.Attributes as S exposing (fontFamily, fontSize, rotate, stroke, strokeWidth, textAnchor, transform, viewBox, x, x1, x2, y, y1, y2)


main : Html msg
main =
    div []
        [ div
            []
            [ rangeScale
            ]
        , div
            []
            [ abScales
            ]

        {- , div
           [ style "transform" "rotateY(180deg)" ]
           [ rangeScale
           , abScales
           ]
        -}
        ]


tickSize i =
    case ( modBy 10 i, modBy 5 i ) of
        ( 0, 0 ) ->
            60

        ( _, 0 ) ->
            45

        _ ->
            30


labelWithModifier f spacing bigness i =
    let
        rightEdgeLabel =
            [ Svg.text_
                [ x <|
                    String.fromFloat <|
                        (toFloat i * spacing)
                , y <| String.fromFloat <| ruleWidthSVG - textInset
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

        leftEdgeLabel =
            [ Svg.text_
                [ x <|
                    String.fromFloat <|
                        (toFloat i * spacing)
                            + 40
                , y <| String.fromFloat <| 0 - ruleWidthSVG + textInset
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
    in
    if modBy 10 i == 0 then
        rightEdgeLabel ++ leftEdgeLabel

    else
        []


inchSpacing =
    25.4


cmSpacing =
    10.0


textInset =
    80


systemTextY =
    45


ruleWidth =
    -- width of physical rule in cm
    4


ruleWidthSVG =
    200


printerScaling =
    1.0544


viewBoxWidth =
    1400.0 * printerScaling


pixelWidth =
    String.fromFloat viewBoxWidth ++ "px"


bracket y left right =
    -- Each bracket is six line segments.
    -- Probably neater to use SVG path but barely worth it.
    let
        centre =
            (left + right) // 2

        notchHeight =
            15

        fromEdge =
            125

        endInset =
            5

        notchHalfWidth =
            -- Doubles as length of end droop
            5

    in
    [ Svg.line
        [ x1 <| String.fromFloat (toFloat (left + endInset) * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge + notchHeight
        , x2 <| String.fromFloat (toFloat (left + endInset + notchHalfWidth) * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (left + endInset + notchHalfWidth) * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat (centre - notchHalfWidth) * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (centre - notchHalfWidth) * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat centre * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge - notchHeight
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat centre * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge - notchHeight
        , x2 <| String.fromFloat (toFloat (centre + notchHalfWidth) * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (centre + notchHalfWidth) * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat (right - endInset - notchHalfWidth) * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (right - endInset - notchHalfWidth) * cmSpacing)
        , y1 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat (right - endInset) * cmSpacing)
        , y2 <| String.fromInt <| 0 + ruleWidthSVG - fromEdge + notchHeight
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (left + endInset) * cmSpacing)
        , y1 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge + notchHeight
        , x2 <| String.fromFloat (toFloat (left + endInset + notchHalfWidth) * cmSpacing)
        , y2 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (left + endInset + notchHalfWidth) * cmSpacing)
        , y1 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat (centre - notchHalfWidth) * cmSpacing)
        , y2 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (centre - notchHalfWidth) * cmSpacing)
        , y1 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat centre * cmSpacing)
        , y2 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge - notchHeight
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat centre * cmSpacing)
        , y1 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge - notchHeight
        , x2 <| String.fromFloat (toFloat (centre + notchHalfWidth) * cmSpacing)
        , y2 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (centre + notchHalfWidth) * cmSpacing)
        , y1 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat (right - 10) * cmSpacing)
        , y2 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge
        , stroke "black"
        , strokeWidth "3"
        ]
        []
    , Svg.line
        [ x1 <| String.fromFloat (toFloat (right - notchHalfWidth - endInset) * cmSpacing)
        , y1 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge
        , x2 <| String.fromFloat (toFloat (right - endInset) * cmSpacing)
        , y2 <| String.fromInt <| negate <| 0 + ruleWidthSVG - fromEdge + notchHeight
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
                            * ruleWidthSVG
                , x2 theX
                , y2 <|
                    String.fromInt <|
                        sign
                            * (ruleWidthSVG - tickSize i)
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
        labeller x =
            String.fromInt x
    in
    svg
        [ viewBox "-100 0 5200 200"
        , S.width pixelWidth
        , S.height "600px"
        ]
    <|
        List.concatMap (tick inchSpacing) (List.range 0 200)
            ++ List.concatMap (labelWithModifier labeller inchSpacing "50") (List.range 0 190)


abScales =
    let
        labeller x =
            String.fromInt <| modBy 230 (40 + x)

        commonSystemText sign xPos txt =
            [ Svg.text_
                [ x <| String.fromFloat (toFloat xPos * cmSpacing)
                , y <| String.fromFloat <| sign * systemTextY
                , S.fill "black"
                , textAnchor "middle"
                , fontFamily "monospace"
                , fontSize "40"
                , rotate <|
                    if sign < 0 then
                        "180"

                    else
                        "0"
                ]
                [ Svg.text <|
                    if sign < 0 then
                        String.reverse txt

                    else
                        txt
                ]
            ]

        systemTextRight xPos txt =
            commonSystemText 1 xPos txt

        systemTextLeft xPos txt =
            commonSystemText -1 xPos txt

        aSystemText =
            bracket -140 0 190
                ++ systemTextRight 96 "\"A\" SYSTEM G⍺"
                ++ systemTextLeft 99 "\"A\" SYSTEM G⍺"

        bSystemText =
            bracket -140 190 320
                ++ systemTextRight 255 "\"B\" SYSTEM G⍺"
                ++ systemTextLeft 258 "\"B\" SYSTEM G⍺"
    in
    svg
        [ viewBox "-100 0 5200 200"
        , S.width pixelWidth
        , S.height "600px"
        ]
    <|
        List.concatMap (tick cmSpacing) (List.range 0 310)
            ++ List.concatMap (labelWithModifier labeller cmSpacing "40") (List.range 10 310)
            ++ aSystemText
            ++ bSystemText
