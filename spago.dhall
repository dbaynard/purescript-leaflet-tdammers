{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "leaflet-tdammers"
, dependencies =
    [ "arrays", "console", "effect", "psci-support" ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
, license =
    "MIT"
, repository =
    "git://github.com/tdammers/purescript-leaflet-tdammers"
}
