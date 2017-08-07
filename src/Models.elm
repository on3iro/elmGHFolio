module Models exposing (..)


type alias Model =
    { repositories : List Repository }


type alias Repository =
    { id : Int
    , name : String
    , url : String
    , description : String
    , fork : Bool
    , mainLang : String
    }


initalModel : Model
initalModel =
    { repositories =
        [ { id = 12
          , name = "Test"
          , url = "test.com"
          , description = "Build nice things"
          , fork = False
          , mainLang = "Elm"
          }
        ]
    }
