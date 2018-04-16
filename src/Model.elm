module Model exposing (..)

import Dict exposing (Dict)
import Http exposing (Error)


type alias Model =
    Maybe (Result Error CV)


type alias PhoneDetails =
    { number : String
    , label : String
    }


type alias PersonalInformation =
    { name : String
    , label : String
    , summary : String
    , email : String
    , website : String
    , dateOfBirth : String
    , nationalities : List String
    , phone : List PhoneDetails
    , location : Dict String String
    }


type alias CV =
    { id : String
    , version : String
    , personalInformation : PersonalInformation
    }
