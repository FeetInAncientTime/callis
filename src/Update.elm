module Update exposing (..)

import Decoder exposing (cvDecoder)
import Http
import Json.Decode
import Model exposing (Model)


type Msg
    = Init (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Init result ->
            case result of
                Ok data ->
                    case Json.Decode.decodeString cvDecoder data of
                        Ok cv ->
                            ( Just (Ok cv), Cmd.none )

                        Err e ->
                            ( Just (Err (Http.BadUrl (toString e))), Cmd.none )

                Err e ->
                    ( Just (Err e), Cmd.none )
