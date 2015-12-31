## Tooth&Claw TileServer

# URL PARAMS

*BASE URL:* http://tiles.toothandclaw.co

next we have either `t` for Tiles, or `b` for Badges

`http://tiles.toothandclaw.co/t`

then, `c` or no `c` for _cached_ (this may be dropped in future as they all may be cached)
non-cached is mostly for testing...

`http://tiles.toothandclaw.co/t/c/`

Next is the name of the tile -- currently accepted names are:

- el
- en
- eq
- ech
- small
- plus
- cross
- square
- square2
- square3
- hall
- house
- house2
- house3
- house4
- water
- cemetery
- field
- woods
- forest
- mountain
- fort
- parking
- river
- river_turn
- bridge
- bridge_broken
- tunnel
- tunnel_cls
- tunnel_v
- tunnel_v_cls

Then, add `.svg` to the end.

`http://tiles.toothandclaw.co/t/c/hall.svg`
![](http://tiles.toothandclaw.co/t/c/hall.svg)

Now we can manipulate the tile by adding params.  Choices are:
 - `s` for Size -- can be anything from 1 to 1000 (default size is 200)
 - `c` for Color -- colors the tile with any HTML 3 or 6 digit color code
  - _e.g._ c=666, c=AABBCD
  - default color is DDDCBF
 - `r` for Rotation
  - 0-3 rotate the tile 90 degrees times the number _.e.g._ 2 = (90 * 2) degrees
  - 4 flips the tile horizontally
  - 5 flips the tile vertically

`http://tiles.toothandclaw.co/t/c/hall.svg?s=100&c=27b`

![](http://tiles.toothandclaw.co/t/c/hall.svg?s=100&c=27b)




All images Copyright 2008-2016 Ben Sharpe. All rights reserved.

