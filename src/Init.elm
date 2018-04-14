module Init exposing (..)

import Http
import Model exposing (Model)
import Update exposing (Msg)


init : ( Model, Cmd Msg )
init =
    ( Nothing
    , fetchCV
    )


cvUrl : String
cvUrl =
    "./cv.json"


cvHttpRequest : Http.Request String
cvHttpRequest =
    Http.getString cvUrl


fetchCV : Cmd Msg
fetchCV =
    Http.send Update.Init cvHttpRequest
