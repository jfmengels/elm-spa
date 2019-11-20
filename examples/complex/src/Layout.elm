module Layout exposing (transition, view)

import App.Page
import App.Transition as Transition exposing (Transition)
import Components.Button
import Components.Styles as Styles
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Global
import Html.Attributes as Attr
import Utils.Spa as Spa


transition : Transition (Element msg)
transition =
    Transition.fadeUi 300


view : Spa.Context msg -> Element msg
view { page, global, toMsg } =
    column
        [ Font.size 16
        , Font.color Styles.colors.jet
        , Font.family Styles.fonts.sans
        , paddingEach
            { top = 32
            , left = 16
            , right = 16
            , bottom = 128
            }
        , spacing 32
        , width (fill |> maximum 640)
        , height fill
        , centerX
        ]
        [ Element.map toMsg (viewNavbar global.user)
        , page
        ]


viewNavbar : Maybe String -> Element Global.Msg
viewNavbar user_ =
    row
        [ width fill
        , spacing 24
        ]
        [ row [ Font.size 18, spacing 24 ] <|
            (link
                [ Font.size 20
                , Font.semiBold
                , Font.color Styles.colors.coral
                , Styles.transition
                    { property = "opacity"
                    , speed = 150
                    }
                , mouseOver [ alpha 0.6 ]
                ]
                { label = text "elm-spa"
                , url = "/"
                }
                :: List.map viewLink
                    [ ( "docs", "/docs" )
                    , ( "guide", "/guide" )
                    ]
            )
        , el [ alignRight ] <|
            case user_ of
                Just name ->
                    Components.Button.view
                        { onPress = Just Global.SignOut
                        , label = text ("sign out " ++ name)
                        }

                Nothing ->
                    viewButtonLink ( "sign in", "/sign-in" )
        ]


viewLink : ( String, String ) -> Element msg
viewLink ( label, url ) =
    link Styles.link
        { url = url
        , label = text label
        }


viewButtonLink : ( String, String ) -> Element msg
viewButtonLink ( label, url ) =
    link Styles.button
        { url = url
        , label = text label
        }
