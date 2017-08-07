module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { repositories : WebData (List Repository) }


type alias Repository =
    { id : Int
    , name : String
    , url : String
    , description : String
    , fork : Bool
    , language : String
    }


initalModel : Model
initalModel =
    { repositories =
        RemoteData.Loading
    }
