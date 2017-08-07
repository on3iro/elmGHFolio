module Main exposing (..)

import Html exposing (Html, div, text, program)
import Models exposing (Model, initalModel)
import Views exposing (..)
import Msgs exposing (Msg)
import Update exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initalModel, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- Main


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
