module Views exposing (..)

import Html exposing (Html, div, text, ul, li, p)
import Models exposing (..)
import Msgs exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ renderRepos model.repositories ]


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
        , p [] [ text repo.mainLang ]
        ]
