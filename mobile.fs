#light

//Declare mobiles structure
type Mobile =
    // Declare a mobile that has a ball
    | WithBall of int * int
    // Declare a mobile that has a strut
    | WithStruts of int * ((int * Mobile) * (int * Mobile));;

//Cord and ball mobile
let mobile1 = WithBall(5, 5);;

//Class example
let mobile2 = WithStruts(2, (
  (20, WithStruts(1, (
    (5, WithBall(1, 5)),
    (5, WithStruts(1, (
      (4, WithBall(5, 3)),
      (6, WithBall(1, 2))
    )))
   ))), 
  (10, WithBall(5, 20))
));;

//Unbalanced example
let mobile3 = WithStruts(2, (
  (20, WithStruts(1, (
    (5, WithBall(1, 5)),
    (5, WithStruts(1, (
      (4, WithBall(5, 3)),
      (6, WithBall(1, 2))
    )))
  ))), 
  (10, WithBall(5, 21))
));;

//Finds total weight of passed mobile
let rec totalWeight(mobile : Mobile) =
  //Match mobile structure to sub-type
  match mobile with
  //When cord and ball, return weight
  | WithBall(_, weight) -> weight
  //When cord and strut, return weight of left and right added
  | WithStruts(_, ((_, left), (_, right))) -> totalWeight(left) + totalWeight(right);;
   
//Finds total height of passed mobile
let rec totalHeight(mobile : Mobile) =
  //Match mobile structure to sub-type
  match mobile with
  //When cord and ball, return height
  | WithBall(height, _) -> height
  //When cord and strut, return height 
  | WithStruts(height, ((_, left), (_, right))) -> height + 
    //plus the greater of left and right
    if totalHeight(left) > totalHeight(right) 
    then totalHeight(left) 
    else totalHeight(right);;

//Figures out if passed mobile is balanced
let rec isBalanced(mobile : Mobile) =
  //Match mobile structure to sub-type
  match mobile with
  //When cord and ball, mobile is balanced
  | WithBall(_, _) -> true
  //When cord and strut return true if
  | WithStruts(_, ((leftWidth, left), (rightWidth, right))) -> 
    //left and right are balanced
    isBalanced(left) && isBalanced(right)
      //and the left width * left weight is = to the right width * right weight 
      && leftWidth * totalWeight(left) = rightWidth * totalWeight(right)

printfn "displaying results for cord and ball";;
printfn "total weight is %d" (totalWeight(mobile1));;
printfn "total height is %d" (totalHeight(mobile1));;
printfn "is balanced? %b" (isBalanced(mobile1));;
printfn "displaying results for class example";;
printfn "total weight is %d" (totalWeight(mobile2));;
printfn "total height is %d" (totalHeight(mobile2));;
printfn "is balanced? %b" (isBalanced(mobile2));;
printfn "displaying results for unbalanced example";;
printfn "total weight is %d" (totalWeight(mobile3));;
printfn "total height is %d" (totalHeight(mobile3));;
printfn "is balanced? %b" (isBalanced(mobile3));;

open System
//Pause input
Console.ReadKey(true)