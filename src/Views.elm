module Views exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Models exposing (..)
import Msgs exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ maybeList model.repositories model.filter
        , renderDescription model.description
        , input
            [ type_ "text"
            , placeholder "Filter"
            , onInput Msgs.ChangeFilter
            ]
            []
        ]


maybeList : WebData (List Repository) -> Filter -> Html Msg
maybeList response filter =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success repos ->
            repos
                |> filterRepos filter
                |> renderRepos

        RemoteData.Failure error ->
            text (toString error)


filterRepos : Filter -> List Repository -> List Repository
filterRepos filter repos =
    List.filter
        (\r -> String.startsWith (String.toLower filter) (String.toLower r.language))
        repos


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
