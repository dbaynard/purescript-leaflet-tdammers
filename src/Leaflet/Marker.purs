module Leaflet.Marker
( Marker
, marker
, Option (..)
, draggable
, keyboard
, title
, alt
, zIndexOffset
, opacity
, riseOnHover
, riseOffset
, pane
, layerOption
, attribution
)
where

import Prelude
import Effect (Effect)
import Leaflet.LatLng (LatLng)
import Leaflet.Options (class IsOption, Options, mkOption, mkOptions, toOption)
import Leaflet.Layer as Layer
import Leaflet.Layer (class IsLayer)
import Unsafe.Coerce (unsafeCoerce)
import Leaflet.Evented (class Evented)
import Leaflet.MouseInteraction (MouseEvent, MouseEventHandle, MouseEventType, offMouseEvent, onMouseEvent)

foreign import data Marker :: Type

instance isLayerMarker :: IsLayer Marker where
  toLayer = unsafeCoerce

foreign import markerJS :: LatLng
                        -> Options
                        -> Effect Marker

-- | Options to be passed to a marker layer at construction time. See
-- | http://leafletjs.com/reference-1.0.3.html#marker for an explanation of
-- | each option.
data Option
  = Draggable Boolean
  | Keyboard Boolean
  | Title String
  | Alt String
  | ZIndexOffset Int
  | Opacity Number
  | RiseOnHover Boolean
  | RiseOffset Int
  | Pane String
-- | Icon Icon
  | LayerOption Layer.Option

draggable :: Boolean -> Option
draggable = Draggable

keyboard :: Boolean -> Option
keyboard = Keyboard

title :: String -> Option
title = Title

alt :: String -> Option
alt = Alt

zIndexOffset :: Int -> Option
zIndexOffset = ZIndexOffset

opacity :: Number -> Option
opacity = Opacity

riseOnHover :: Boolean -> Option
riseOnHover = RiseOnHover

riseOffset :: Int -> Option
riseOffset = RiseOffset

pane :: String -> Option
pane = Pane

layerOption :: Layer.Option -> Option
layerOption = LayerOption 

attribution :: String -> Option
attribution = layerOption <<< Layer.attribution

instance isOptionMarkerOption :: IsOption Option where
  toOption = case _ of
    Draggable x -> mkOption "draggable" x
    Keyboard x -> mkOption "keyboard" x
    Title x -> mkOption "title" x
    Alt x -> mkOption "alt" x
    ZIndexOffset x -> mkOption "zIndexOffset" x
    Opacity x -> mkOption "opacity" x
    RiseOnHover x -> mkOption "riseOnHover" x
    RiseOffset x -> mkOption "riseOffset" x
    Pane x -> mkOption "pane" x
    LayerOption o -> toOption o

-- | `marker position options` creates a new
-- | [marker](http://leafletjs.com/reference-1.0.3.html#marker) at the
-- | specified geographic coordinates.
-- |
marker :: LatLng
       -> Array Option
       -> Effect Marker
marker position optionList = do
  let options = mkOptions optionList
  markerJS position options

instance eventedMouseMarker :: Evented MouseEventType MouseEvent MouseEventHandle Marker where
  on e = onMouseEvent e <<< unsafeCoerce
  off e = offMouseEvent e <<< unsafeCoerce
