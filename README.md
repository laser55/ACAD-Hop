# ACAD-LayOrd
Simple AutoCAD script for breaking lines and polylines and adding line hops for schematics in a few simple clicks and presses.

## Installation
Edit your existing acad.lsp file to include the .lsp in this package, or create yourself a new one with the below:
```
(defun s::startup ()
(load "hop.lsp")
)
```
Then place the acad.lsp in your chosen AutoCAD file search path.

Place the hop.lsp in your chosen AutoCAD file search path.

Not sure where you should put it? Example:
```
C:\Program Files\Autodesk\AutoCAD 2015
```
```
C:\Program Files\Autodesk\AutoCAD 2015\Acade
```
If you have trouble, read the AutoCAD documentation for where to put these files. ```DSETTINGS``` will allow you to check your current paths.

Optionally, you can place the hop.lsp anywhere and load it via drop and drag, or menu for each drawing you wish to use it on.

An acad.lsp is included in the package for convenience for new users.

## Usage
The AutoCAD command to run is ```hop```.
This will begin the prompts.

First enter a gap size, this defaults to 200.

Following this, select the line you want to break and add the line hop to.

Next select the intersecting line you wish to use to break the first line.

Finally, select your start point for the line hop arc - then the arc midpoint - then the arc end point as prompted.