module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)
import Msgs exposing (Msg)
import Models exposing (Model, Repository)
import RemoteData


fetchRepos : Cmd Msg
fetchRepos =
    Http.get fetchRepoUrl reposDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchRepos


fetchRepoUrl : String
fetchRepoUrl =
    "https://api.github.com/users/on3iro/repos"


reposDecoder : Decode.Decoder (List Repository)
reposDecoder =
    Decode.list repoDecoder


repoDecoder : Decode.Decoder Repository
repoDecoder =
    decode Repository
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "url" Decode.string
        |> optional "description" Decode.string "No Description"
        |> required "fork" Decode.bool
        |> optional "language" Decode.string " - "
