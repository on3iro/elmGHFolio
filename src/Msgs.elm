module Msgs exposing (..)

import Models exposing (Repository)
import RemoteData exposing (WebData)


type Msg
    = OnFetchRepos (WebData (List Repository))
    | ShowDescription String
    | CloseDescription
    | ChangeFilter String
