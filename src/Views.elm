module Views exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import RemoteData exposing (WebData)
import Models exposing (..)
import Msgs exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ maybeList model.repositories
        , renderDescription model.description
        ]


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
    li [ onClick (Msgs.ShowDescription repo.description) ]
        [ div []
            [ text repo.language
            , text (" " ++ repo.name)
            ]
        , div []
            [ text repo.url
            , if repo.fork then
                text " fork"
              else
                text ""
            ]
        ]


renderDescription : String -> Html Msg
renderDescription desc =
    div []
        [ p [] [ text desc ]
        , if desc /= "" then
            button
                [ onClick Msgs.CloseDescription ]
                [ text "Close" ]
          else
            text ""
        ]
