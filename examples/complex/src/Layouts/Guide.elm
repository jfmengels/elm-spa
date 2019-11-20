module Layouts.Guide exposing (transition, view)

import App.Transition as Transition exposing (Transition)
import Components.Styles as Styles
import Element exposing (..)
import Global
import Utils.Spa as Spa


transition : Transition (Element msg)
transition =
    Transition.none


view : Spa.Context msg -> Element msg
view { page } =
    column
        [ width fill
        , spacing -128
        ]
        [ page
        , row [ centerX, spacing 16 ]
            [ link Styles.link { label = text "programming", url = "/guide/programming" }
            , link Styles.link { label = text "elm", url = "/guide/elm" }
            ]
        ]
