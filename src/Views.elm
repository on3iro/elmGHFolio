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
            , placeholder "Filter by Language"
            , onInput Msgs.ChangeFilter
            ]
            []
        , if not <| String.isEmpty model.filter then
            button
                [ onClick Msgs.ClearFilter ]
                [ text "x" ]
          else
            text ""
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
        (\r ->
            r
                |> .language
                |> String.toLower
                |> String.startsWith filter
        )
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
            [ a
                [ target "_blank"
                , href repo.url
                ]
                [ text repo.url ]
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
