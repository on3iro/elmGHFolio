module Update exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchRepos response ->
            ( { model | repositories = response }, Cmd.none )

        Msgs.ShowDescription desc ->
            ( { model | description = desc }, Cmd.none )

        Msgs.CloseDescription ->
            ( { model | description = "" }, Cmd.none )

        Msgs.ChangeFilter filter ->
            ( { model | filter = (String.toLower filter) }, Cmd.none )

        Msgs.ClearFilter ->
            ( { model | filter = "" }, Cmd.none )
