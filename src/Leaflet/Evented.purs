module Leaflet.Evented
where

import Prelude
import Effect (Effect)

class Evented t e h a | t -> e, t -> h where
  on:: t
    -> a
    -> (e -> Effect Unit)
    -> Effect h
  off :: t
      -> a
      -> h
      -> Effect Unit
