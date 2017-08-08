module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { repositories : WebData (List Repository)
    , description : String
    , filter : String
    }


type alias Repository =
    { id : Int
    , name : String
    , url : String
    , description : String
    , fork : Bool
    , language : String
    }


type alias Filter =
    String


initalModel : Model
initalModel =
    { repositories =
        RemoteData.Loading
    , description = ""
    , filter = ""
    }
