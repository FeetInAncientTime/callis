module Model exposing (..)

import Dict exposing (Dict)
import Http exposing (Error)


type alias Model =
    Maybe (Result Error CV)


type alias PersonalInformation =
    { name : String
    , email : String
    , website : String
    , dateOfBirth : String
    , nationalities : List String
    , phone : Dict String String
    , location : Dict String String
    }


type alias CV =
    { id : String
    , version : String
    , personalInformation : PersonalInformation
    }
