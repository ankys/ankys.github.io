#!/bin/bash

HOST=smaux.math.kyoto-u.ac.jp
LOCALDIR=_site
REMOTEDIR=~/pub/html

homura b
rsync -auvz --chmod=F644,D755 "$LOCALDIR/" "$HOST:$REMOTEDIR/"
