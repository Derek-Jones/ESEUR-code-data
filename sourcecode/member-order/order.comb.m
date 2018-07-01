/*
 * order.comb.m, 20 Feb 13
 *
 * The number of ways n items can be ordered with no
 * item being adjacent to an item of the same type.
 * Taken from mathoverflow answer.
 */
a:matrix([0,0,0],[x,0,0],[x,0,0]);
b:matrix([0,y,0],[0,0,0],[0,y,0]);
c:matrix([0,0,z],[0,0,z],[0,0,0]);

one:matrix([1],[1],[1]);
half:matrix([1/2,1/2,1/2]);

/* value of power is the total number of items */

expand(half.((a+b+c)^^4).one);
 
