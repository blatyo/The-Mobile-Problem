#!/usr/bin/perl -w
#
# Version:
# $Id$
# 
# author name: Allen Madsen
# description:
#    Displays the weight, height, and weather or not a mobile is ballanced
#    for each of the mobiles defined in @mobiles.
#    Mobile data structure is defined by the following psuedo free grammar:
#    C -> [N, S|B]      #Cord
#    S -> P,P           #Strut
#    P -> [N, C]        #Strut Part - Right or Left
#    B -> N             #Ball
#    N -> /[1-9]\d*/    #Number
# ###################################################################

@mobiles = (
  #sample given
  [2,[20,[1,[5,[1,5]],[5,[1,[4,[5,3]],[6,[1,2]]]]]],[10,[5,20]]],
  #chord and ball
  [9, 20],
  #mobile with 1 strut with same submobiles on each side
  [5, [3, [2, 10]], [3, [2, 10]]],
  #unballanced mobile
  [1,[10,[7,7]],[10,[8,8]]],
  #sample given modified to be unballanced
  [2,[20,[1,[5,[8,5]],[5,[1,[3,[5,3]],[6,[1,2]]]]]],[3,[3,20]]],
  #ballanced top, unballanced submobile
  [5, [3, [2, [5, [2, 10]], [3, [2, 10]]]], [3, [2, 20]]],
);

#starts execution
&main(@mobiles);
sub main{
  my $i = 0;
  #for all the mobiles
  foreach my $mobile (@_){
    ++$i;
    print "Mobile $i\n";
    #calculate the info
    my $height = &total_height($mobile);
    my $weight = &total_weight($mobile);
    my $ballanced = &is_ballanced($mobile);
    #and show it
    print "height: $height\nweight: $weight\nballanced: ";
    if($ballanced){
      print "yes";
    } else {
      print "no";
    }
    print "\n\n";
  }
}

sub total_height{
  my $mobile = $_[0];
  #when we have a chord and a ball
  if(@$mobile == 2){
    #return the chord height
    return $mobile->[0];
  } else { #when we have a chord and strut
    #find the left height
    my $left_height = &total_height($mobile->[1][1]);
    #and right height
    my $right_height = &total_height($mobile->[2][1]);
    #decide which is bigger and return that one added to 
    #the current height
    if($left_height > $right_height){
      return $left_height + $mobile->[0];
    } else {
      return $right_height + $mobile->[0];
    }
  }
}

sub total_weight{
  my $mobile = $_[0];
  #when we have a chord and a ball
  if(@$mobile == 2){
    #return the ball weight
    return int($mobile->[1]);
  } else { #when we have a chord and a strut
    #get the total weight of the left and right and return them
    return &total_weight($mobile->[1][1]) + &total_weight($mobile->[2][1]); 
  }
}

sub is_ballanced{
  my $mobile = $_[0];
  #when we have a chord and a ball
  if(@$mobile == 2){
    #it is always ballanced so return 1
    return 1;
  } else { #when we have a chord and a strut
    #get the left weight
    my $left_weight = &total_weight($mobile->[1][1]);
    #and the right weight
    my $right_weight = &total_weight($mobile->[2][1]);
    #and the make sure this level is ballanced and the 
    #left and right are ballanced as well;
    return $left_weight * $mobile->[1][0] == $right_weight * $mobile->[2][0] 
      && &is_ballanced($mobile->[1][1]) && &is_ballanced($mobile->[2][1]); 
  }
}

# ###################################################################
# Revision History:
# $Log$
# 
__END__

=head1 NAME
mobiles.pl -- displays height, weight, and weather or not the
              mobile is ballanced

=head1 SYNOPSIS
mobiles.pl

=head1 DESCRIPTION
Program displays height, weight, and weather or not the
mobile is ballanced

=head1 AUTHOR
Allen Madsen (acm1546@rit.edu)

=head1 README
mobiles.pl filename

=head1 PREREQUISITES
none.