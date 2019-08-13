module Leaflet.MouseInteraction
where

import Prelude
import Leaflet.LatLng (LatLng)
import Leaflet.Types (Point)
import Effect (Effect)
import Data.Newtype (class Newtype)

foreign import data MouseEventTarget :: Type

-- | Metadata for a mouse event.
newtype MouseEvent =
  MouseEvent
      { latlng :: LatLng -- ^ Mouse position in geocoordinate space
      , layerPoint :: Point -- ^ Mouse position relative to the layers
      , containerPoint :: Point -- ^ Mouse position relative to the container element
      }

derive instance newtypeMouseEvent :: Newtype MouseEvent _

foreign import data MouseEventHandle :: Type

data MouseEventType
  = MouseMove
  | MouseOver
  | MouseOut
  | MouseUp
  | MouseDown
  | Click
  | DblClick

mouseEventKey :: MouseEventType -> String
mouseEventKey MouseMove = "mousemove"
mouseEventKey MouseOver = "mouseover"
mouseEventKey MouseOut = "mouseout"
mouseEventKey MouseUp = "mouseup"
mouseEventKey MouseDown = "mousedown"
mouseEventKey Click = "click"
mouseEventKey DblClick = "dblclick"

-- | Subscribe to a mouse event by name.
foreign import onMouseEventJS :: String
                              -> MouseEventTarget
                              -> (MouseEvent -> Effect Unit)
                              -> Effect MouseEventHandle

-- | Unsubscribe from a mouse event by name.
foreign import offMouseEventJS :: String
                               -> MouseEventTarget
                               -> MouseEventHandle
                               -> Effect Unit

onMouseEvent :: MouseEventType
             -> MouseEventTarget
             -> (MouseEvent -> Effect Unit)
             -> Effect MouseEventHandle
onMouseEvent = onMouseEventJS <<< mouseEventKey

offMouseEvent :: MouseEventType
              -> MouseEventTarget
              -> MouseEventHandle
              -> Effect Unit
offMouseEvent = offMouseEventJS <<< mouseEventKey
