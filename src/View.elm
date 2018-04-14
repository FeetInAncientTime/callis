module View exposing (..)

import Dict exposing (Dict)
import Html exposing (..)
import Model exposing (Model, PersonalInformation)


rowInfo : String -> String -> Html msg
rowInfo name value =
    div []
        [ span [] [ text name ]
        , span [] [ text " : " ]
        , span [] [ text value ]
        ]


phoneRowInfo : Dict String String -> Html msg
phoneRowInfo phoneDetails =
    rowInfo "Téléphone" (Maybe.withDefault "" (Dict.get "mobile" phoneDetails))


locationRowInfo : Dict String String -> Html msg
locationRowInfo locationDetails =
    div []
        [ rowInfo "Adresse" (Maybe.withDefault "" (Dict.get "address" locationDetails))
        , rowInfo "Code postal" (Maybe.withDefault "" (Dict.get "postalCode" locationDetails))
        ]


personalInformationSection : PersonalInformation -> Html msg
personalInformationSection personalInformation =
    section []
        [ h2 [] [ text "Informations personnelles" ]
        , rowInfo "Nom" personalInformation.name
        , rowInfo "E-mail" personalInformation.email
        , rowInfo "Date de naissance" personalInformation.dateOfBirth
        , rowInfo "Nationalité(s)" (toString personalInformation.nationalities)
        , phoneRowInfo personalInformation.phone
        , locationRowInfo personalInformation.location

        -- TODO profiles
        ]


view : Model -> Html msg
view model =
    case model of
        Nothing ->
            div [] [ text "Waiting..." ]

        Just result ->
            case result of
                Ok cv ->
                    div []
                        [ personalInformationSection cv.personalInformation
                        ]

                Err e ->
                    div [] [ text (toString e) ]
