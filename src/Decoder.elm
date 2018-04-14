module Decoder exposing (..)

import Json.Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (decode, hardcoded, optional, required)
import Model exposing (CV, PersonalInformation)


personalInformationDecoder : Decoder PersonalInformation
personalInformationDecoder =
    decode PersonalInformation
        |> required "name" string
        |> required "email" string
        |> optional "website" string ""
        |> required "dateOfBirth" string
        |> required "nationalities" (Json.Decode.list string)
        |> required "phone" (Json.Decode.dict string)
        |> required "location" (Json.Decode.dict string)


cvDecoder : Decoder CV
cvDecoder =
    decode CV
        |> required "id" string
        -- `null` decodes to `Nothing`
        |> hardcoded "0.0.1"
        |> required "personalInformation" personalInformationDecoder
