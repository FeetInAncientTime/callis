module Main exposing (..)

import Html exposing (..)
import Init exposing (init)
import Model exposing (CV, Model)
import Update exposing (Msg, update)
import View exposing (view)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
