module Decoder exposing (..)

{-| This library provides a decoder for CV documents in the specified JSON format.

The order of the elements to decode _must_ macth the order of the elements declared
in the model's type alias.

-}

import Json.Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (decode, hardcoded, optional, required)
import Model exposing (CV, PersonalInformation, PhoneDetails)


phoneDetailsDecoder : Decoder PhoneDetails
phoneDetailsDecoder =
    decode PhoneDetails
        |> required "number" string
        |> required "label" string


personalInformationDecoder : Decoder PersonalInformation
personalInformationDecoder =
    decode PersonalInformation
        |> required "name" string
        |> optional "label" string ""
        |> optional "summary" string ""
        |> required "email" string
        |> optional "website" string ""
        |> required "dateOfBirth" string
        |> required "nationalities" (Json.Decode.list string)
        |> required "phone" (Json.Decode.list phoneDetailsDecoder)
        |> required "location" (Json.Decode.dict string)


cvDecoder : Decoder CV
cvDecoder =
    decode CV
        |> required "id" string
        |> hardcoded "0.0.1"
        |> required "personalInformation" personalInformationDecoder
