module Views exposing (..)

import Html exposing (Html, div, text, ul, li, p)
import RemoteData exposing (WebData)
import Models exposing (..)
import Msgs exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ maybeList model.repositories ]


maybeList : WebData (List Repository) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success repos ->
            renderRepos repos

        RemoteData.Failure error ->
            text (toString error)


renderRepos : List Repository -> Html Msg
renderRepos repositories =
    div []
        [ ul []
            (List.map repoItem repositories)
        ]


repoItem : Repository -> Html Msg
repoItem repo =
    li []
        [ p [] [ text (toString repo.id) ]
        , p [] [ text repo.name ]
        , p [] [ text repo.url ]
        , p [] [ text repo.description ]
        , p [] [ text (toString repo.fork) ]
        , p [] [ text repo.language ]
        ]
