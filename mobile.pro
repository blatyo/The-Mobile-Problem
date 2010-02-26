% file name: mobiles.pro
% your name: Allen Madsen
% your login: acm1546
% description:  
% 	Solving the mobiles problem yet again

%Sample mobiles
%these can be used by issuing a statement like the following:
% mobiles(simple,Mobile),totalWeight(Mobile,Weight).

%simple
mobiles(simple, mobile(1,5)).
%simple balanced
mobiles(simpleBalanced, mobile(1,2,mobile(1,5),2,mobile(1,5))).
%class example
mobiles(classExample, 
  mobile(2,
    20,mobile(1,
      5,mobile(1,5),
      5,mobile(1,
        4,mobile(5,3),
        6,mobile(1,2))),
    10,mobile(5,20))).
%sabatoged class example
mobiles(unbalanced, 
  mobile(2,
    20,mobile(1,
      5,mobile(1,5),
      5,mobile(1,
        4,mobile(5,3),
        6,mobile(1,2))),
    10,mobile(5,21))).

% contract:
% totalWeight : predicate/2 mobile weight
% purpose:
% determines total weight of a mobile
% header:
% totalWeight( +Mobile, -Weight ).
totalWeight(mobile(_,_,LM,_,RM),W) :- 
  %get total weight of left
  totalWeight(LM,LW),
  %get total weight of right
  totalWeight(RM,RW),
  %add left and right weight
  W is LW + RW.
%when mobile is simple, just return weight
totalWeight(mobile(_,W),W).

% contract:
% totalHeight : predicate/2 mobile height
% purpose:
% determines total height of a mobile
% header:
% totalHeight( +Mobile, -Height ).
totalHeight(mobile(H,_,LM,_,RM),TH) :- 
  %get total height of left
  totalHeight(LM,LH),
  %get total height of right
  totalHeight(RM,RH),
  %when right height is greater
  LH < RH,
  %total height is right height plus current height
  TH is RH + H.
totalHeight(mobile(H,_,LM,_,RM),TH) :- 
  %get total height of left
  totalHeight(LM,LH),
  %get total height of right
  totalHeight(RM,RH),
  %when left height is greater
  LH >= RH,
  %total height is left height plus current height
  TH is LH + H.
%when mobile is simple, just return height
totalHeight(mobile(H,_),H).

% contract:
% isBalanced : predicate/1 mobile
% purpose:
% determines if a mobile is balanced
% header:
% totalWeight( +Mobile ).
isBalanced(mobile(_,L,LM,R,RM)) :- 
  %if left is balanced
  isBalanced(LM),
  %and right is balanced
  isBalanced(RM),
  %get total weight of left
  totalWeight(LM,LW),
  %get total weight of right
  totalWeight(RM,RW),
  %left balance factor is left width times left weight
  LB is L * LW,
  %right balance factor is right width times right weight
  RB is R * RW,
  %and both factors are equal, mobile is ballanced
  LB = RB.
%simple mobile is always balanced
isBalanced(mobile(_,_)).

