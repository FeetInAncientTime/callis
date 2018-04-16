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


phoneRowInfo : List Model.PhoneDetails -> Html msg
phoneRowInfo phoneDetails =
    div []
        [ rowInfo "Téléphone" (String.join "," (List.map (\phoneDetail -> "(" ++ phoneDetail.label ++ ") " ++ phoneDetail.number) phoneDetails))
        ]


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
        , rowInfo "Label" personalInformation.label
        , rowInfo "Summary" personalInformation.summary
        , rowInfo "E-mail" personalInformation.email
        , rowInfo "Date de naissance" personalInformation.dateOfBirth
        , rowInfo "Nationalité(s)" (String.join ", " personalInformation.nationalities)
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
