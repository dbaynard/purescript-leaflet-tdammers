module Leaflet.TileLayer
( tileLayer
, UrlTemplate (..)
, Option (..)
, minZoom
, maxZoom
, minNativeZoom
, maxNativeZoom
, subdomains
, errorTileUrl
, zoomOffset
, tMS
, zoomReverse
, detectRetina
, crossOrigin
, gridSize
, opacity
, updateWhenIdle
, updateWhenZooming
, updateInterval
, zIndex
, bounds
, noWrap
, pane
, className
, keepBuffer
, attribution
)
where

import Prelude
import Effect (Effect)
import Leaflet.LatLng (LatLngBounds)
import Leaflet.Options (class IsOption, Options, mkOption, mkOptions, toOption)
import Data.Maybe (Maybe)
import Leaflet.GridLayer as GridLayer
import Leaflet.Layer (Layer)

-- | A URL template for tile layers.
type UrlTemplate = String

foreign import tileLayerJS :: UrlTemplate
                           -> Options
                           -> Effect Layer

-- | Options to be passed to a tile layer at construction time. See
-- | http://leafletjs.com/reference-1.0.3.html#tilelayer for an explanation of
-- | each option.
data Option
  = MinZoom Int
  | MaxZoom Int
  | MinNativeZoom (Maybe Int)
  | MaxNativeZoom (Maybe Int)
  | Subdomains (Array String)
  | ErrorTileUrl String
  | ZoomOffset Int
  | TMS Boolean
  | ZoomReverse Boolean
  | DetectRetina Boolean
  | CrossOrigin Boolean
  | GridLayerOption GridLayer.Option

minZoom :: Int -> Option
minZoom = MinZoom 

maxZoom :: Int -> Option
maxZoom = MaxZoom 

minNativeZoom :: (Maybe Int) -> Option
minNativeZoom = MinNativeZoom 

maxNativeZoom :: (Maybe Int) -> Option
maxNativeZoom = MaxNativeZoom 

subdomains :: (Array String) -> Option
subdomains = Subdomains 

errorTileUrl :: String -> Option
errorTileUrl = ErrorTileUrl 

zoomOffset :: Int -> Option
zoomOffset = ZoomOffset 

tMS :: Boolean -> Option
tMS = TMS 

zoomReverse :: Boolean -> Option
zoomReverse = ZoomReverse 

detectRetina :: Boolean -> Option
detectRetina = DetectRetina 

crossOrigin :: Boolean -> Option
crossOrigin = CrossOrigin 

gridLayerOption :: GridLayer.Option -> Option
gridLayerOption = GridLayerOption 

gridSize :: Int -> Option
gridSize = gridLayerOption <<< GridLayer.gridSize

opacity :: Number -> Option
opacity = gridLayerOption <<< GridLayer.opacity

updateWhenIdle :: Boolean -> Option
updateWhenIdle = gridLayerOption <<< GridLayer.updateWhenIdle

updateWhenZooming :: Boolean -> Option
updateWhenZooming = gridLayerOption <<< GridLayer.updateWhenZooming

updateInterval :: Number -> Option
updateInterval = gridLayerOption <<< GridLayer.updateInterval

zIndex :: Int -> Option
zIndex = gridLayerOption <<< GridLayer.zIndex

bounds :: LatLngBounds -> Option
bounds = gridLayerOption <<< GridLayer.bounds

noWrap :: Boolean -> Option
noWrap = gridLayerOption <<< GridLayer.noWrap

pane :: String -> Option
pane = gridLayerOption <<< GridLayer.pane

className :: String -> Option
className = gridLayerOption <<< GridLayer.className

keepBuffer :: Int -> Option
keepBuffer = gridLayerOption <<< GridLayer.keepBuffer

attribution :: String -> Option
attribution = gridLayerOption <<< GridLayer.attribution

instance isOptionTileLayerOption :: IsOption Option where
  toOption = case _ of
    MinZoom z -> mkOption "minZoom" z
    MaxZoom z -> mkOption "maxZoom" z
    MinNativeZoom z -> mkOption "minNativeZoom" z
    MaxNativeZoom z -> mkOption "maxNativeZoom" z
    Subdomains z -> mkOption "subdomains" z
    ErrorTileUrl z -> mkOption "errorTileUrl" z
    ZoomOffset z -> mkOption "zoomOffset" z
    TMS z -> mkOption "tms" z
    ZoomReverse z -> mkOption "zoomReverse" z
    DetectRetina z -> mkOption "detectRetina" z
    CrossOrigin z -> mkOption "crossOrigin" z
    GridLayerOption o -> toOption o

-- | `tileLayer template options` creates a new
-- | [tile layer](http://leafletjs.com/reference-1.0.3.html#tilelayer) using
-- | the URL template `template` to generate tile URLS.
-- |
-- | The template can use the following variables, written between curly
-- | braces:
-- | - `{z}`: zoom level
-- | - `{x}`, `{y}`: the tile coordinates (after projection), from the range
-- |   `[0..(2 ^ z))`
-- | - `{s}`: subdomain
-- |
-- | Example: `"http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"`
tileLayer :: UrlTemplate
          -> Array Option
          -> Effect Layer
tileLayer url optionList = do
  let options = mkOptions optionList
  tileLayerJS url options

