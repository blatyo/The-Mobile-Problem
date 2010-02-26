\ file name: mobiles.fs
\ your name: Allen Madsen
\ your login: acm1546
\ description:  
\ operates on a mobile

[ifdef] reverse-marker
  reverse-marker
[endif]
marker reverse-marker

s" /usr/share/gforth/0.6.2/compat/struct.fs" included

\ cord structure
struct
  cell% field height
  cell% field type \ -1 for ball, 0 for strut
  cell% field child
end-struct cord%

\ ball structure
struct
  cell% field weight
end-struct ball%

\ strut structure
struct
  cell% field left
  cell% field right
end-struct strut%

\ strut-part structure
struct
  cell% field width
  cell% field cord
end-struct strut-part%

: totalWeight recursive
  \ if ball
  dup type @ if
    \ put weight on stack
    child @ weight @
  else \ if not ball
    \ recurse down each sub-tree to get weight
    \ and add them
    dup
    child @ left @ cord @ totalWeight
    swap 
    child @ right @ cord @ totalWeight 
    +
  then
  ;

: totalHeight recursive
  \ if ball
  dup type @ if
    \ put height on stack
    height @
  else \ if not ball
    dup dup
    \ put height on stack
    height @
    rot
    \ put height of left on stack
    child @ left @ cord @ totalHeight
    rot
    \ put height of right on stack
    child @ right @ cord @ totalHeight 
    over over
    \ if left is greater
    > if
      \ leave only left on stack
      drop
    else \ if left is not greater
      \ leave only right on stack
      nip
    then
    \ add current height plus greater of lower height
    +
  then
  ;

: isBalanced recursive
  \ if ball
  dup type @ if
    \ remove address
    drop
    \ cord and ball is balanced, so true to stack
    -1
  else
    dup dup
    \ get if left is balanced
    child @ left @ cord @ isBalanced
    rot
    \ get if right is balanced
    child @ right @ cord @ isBalanced
    rot
    dup dup dup
    \ get weight of left
    child @ left @ cord @ totalWeight
    swap
    \ get width of left
    child @ left @ width @
    \ multiply them
    *
    rot
    \ get weight of right
    child @ right @ cord @ totalWeight
    rot
    \ get width of right
    child @ right @ width @
    \ multiply them
    *
    \ compare the multiplications and and that together
    \ the balance of right and left
    = and and
  then
  ;

\ a ball construction begin
\ this is cord and ball
ball% %allot constant a-ball
20 a-ball weight !

cord% %allot constant a-mobile
5 a-mobile height !
-1 a-mobile type !
a-ball a-mobile child !
\ a ball construction end

\ b ball construction begin
\ this is an unbalanced mobile
ball% %allot constant b-ball1
20 b-ball1 weight !

cord% %allot constant b-cord1
4 b-cord1 height !
-1 b-cord1 type !
b-ball1 b-cord1 child !

strut-part% %allot constant b-sp1
5 b-sp1 width !
b-cord1 b-sp1 cord !

ball% %allot constant b-ball2
20 b-ball2 weight !

cord% %allot constant b-cord2
5 b-cord2 height !
-1 b-cord2 type !
b-ball2 b-cord2 child !

strut-part% %allot constant b-sp2
7 b-sp2 width !
b-cord2 b-sp2 cord !

strut% %allot constant b-strut
b-sp1 b-strut left !
b-sp2 b-strut right !

cord% %allot constant b-mobile
3 b-mobile height !
0 b-mobile type !
b-strut b-mobile child !
\ b ball construction end

\ c ball construction begin
\ class example
ball% %allot constant c-ball3
3 c-ball3 weight !

ball% %allot constant c-ball2
2 c-ball2 weight !

ball% %allot constant c-ball5
5 c-ball5 weight !

ball% %allot constant c-ball20
20 c-ball20 weight !

cord% %allot constant c-cordl4l
5 c-cordl4l height !
-1 c-cordl4l type !
c-ball3 c-cordl4l child !

cord% %allot constant c-cordl4r
1 c-cordl4r height !
-1 c-cordl4r type !
c-ball2 c-cordl4r child !

strut-part% %allot constant c-spl3l
4 c-spl3l width !
c-cordl4l c-spl3l cord !

strut-part% %allot constant c-spl3r
6 c-spl3r width !
c-cordl4r c-spl3r cord !

strut% %allot constant c-strutl3
c-spl3l c-strutl3 left !
c-spl3r c-strutl3 right !

cord% %allot constant c-cordl3l
1 c-cordl3l height !
-1 c-cordl3l type !
c-ball5 c-cordl3l child !

cord% %allot constant c-cordl3r
1 c-cordl3r height !
0 c-cordl3r type !
c-strutl3 c-cordl3r child !

strut-part% %allot constant c-spl2l
5 c-spl2l width !
c-cordl3l c-spl2l cord !

strut-part% %allot constant c-spl2r
5 c-spl2r width !
c-cordl3r c-spl2r cord !

strut% %allot constant c-strutl2
c-spl2l c-strutl2 left !
c-spl2r c-strutl2 right !

cord% %allot constant c-cordl2l
1 c-cordl2l height !
0 c-cordl2l type !
c-strutl2 c-cordl2l child !

cord% %allot constant c-cordl2r
5 c-cordl2r height !
-1 c-cordl2r type !
c-ball20 c-cordl2r child !

strut-part% %allot constant c-spl1l
20 c-spl1l width !
c-cordl2l c-spl1l cord !

strut-part% %allot constant c-spl1r
10 c-spl1r width !
c-cordl2r c-spl1r cord !

strut% %allot constant c-strutl1
c-spl1l c-strutl1 left !
c-spl1r c-strutl1 right !

cord% %allot constant c-mobile
2 c-mobile height !
0 c-mobile type !
c-strutl1 c-mobile child !
\ c ball construction end

: test-mobiles
  ." testing a-mobile" cr
  ." totalWeight should be 20" cr
  ." totalWeight is " a-mobile totalWeight . cr
  ." totalHeight should be 5" cr
  ." totalHeight is " a-mobile totalHeight . cr
  ." isBalanced should be -1" cr
  ." isBalanced is " a-mobile isBalanced . cr

  ." testing b-mobile" cr
  ." totalWeight should be 40" cr
  ." totalWeight is " b-mobile totalWeight . cr
  ." totalHeight should be 8" cr
  ." totalHeight is " b-mobile totalHeight . cr
  ." isBalanced should be 0" cr
  ." isBalanced is " b-mobile isBalanced . cr

  ." testing c-mobile" cr
  ." totalWeight should be 30" cr
  ." totalWeight is " c-mobile totalWeight . cr
  ." totalHeight should be 9" cr
  ." totalHeight is " c-mobile totalHeight . cr
  ." isBalanced should be -1" cr
  ." isBalanced is " c-mobile isBalanced . cr
  ;
