/* Set build to 0 to render it all
   Set build to one of the following to render each separate part and rotate it for printing:
   1: Top
   2: Middle
   3: Bottom plate
   4: OLED display holder
 */
build=0;
/* Set buttons to 0 for buttons on each side.
   Set buttons to 1 for buttons on the left side.
   Set buttons to 2 for buttons on the right side.
*/
buttons = 1;

flip = (build==0 || build==2) ? 0 : 180;
rotate([flip,0,0]){

if((build == 0) || (build == 1) || (build == 2))
difference(){
// The outside of the box
    union(){
        minkowski(){
            translate([2,2])cube([100.5,80.5,33]);
            difference(){
                sphere(2);
                translate([0,0,-5]) cylinder(h=5,r=5);
            }
        }
    }

// Hollowing out the box
    translate([0,0,-10]) difference(){
        translate([4,4]) cube([96.5,76.5,30+10+1]);
        for(i=[0:5]) translate(screwpattern[i]) cylinder(h=60,d=7);
    }

// PCB cutout
    translate([2,2,14.5]) cube([100.5,80.5,3]);

// Splitting the box in two.
    translate([-2,-2,15.5]) cube([150,150,1]);

// Screw holes for the bottom
    for(i=[0:5]) translate(screwpattern[i])  cylinder(h=16,d=3.2);

// Screw holes for the top witch grips the screws.
    for(i=[0:5]) translate(screwpattern[i]) cylinder(h=32,d=2.8);

// Rotary encoder cutout.
    translate([104.5/4,84.5/2,1]){
        cube([14,14,32*2],center=true);
        cylinder(h=50,d=7);
    }

// Keyboard switches cutout on the side of the box.
if(buttons == 1) translate([104.5-21,0,26]) cube([14,14,14],center=true);
if(buttons == 2) translate([104.5-21,84.5,26]) cube([14,14,14],center=true);
if(buttons <= 1) translate([104.5-21-21,0,26]) cube([14,14,14],center=true);
if(buttons != 1) translate([104.5-21-21,84.5,26]) cube([14,14,14],center=true);

// Cutout for the OLED screen.
    translate([104.5-29,84.5/2,35]) rotate([0,0,270]) screencut();

// BNC cutout
    translate([104.5,84.5/4*2,15/2]) rotate([0,90,0]){
        intersection(){
            cylinder(h=10,d=9.5,center=true);
            cube([10,8,10],center=true);
        }
        translate([0,0,-1]) cylinder(h=10,d=13);
    }

// Headphone jack cutout.
    translate([104.5-7,84.5/4*3,15/2]) rotate([0,90,0]) {
        cylinder(h=10,d=6.2);
        cube([9,13,10],center=true);
    }

// Power switch cutout.
    translate([104.5+1,84.5/4*1,15/2]) rotate([0,90,0]) {
        translate([0, 15/2]) cylinder(h=10,d=2.3,center=true);
        translate([0,-15/2]) cylinder(h=10,d=2.3,center=true);
        hull(){
            cube([3,6,10],center=true);
            translate([0,0,4]) cube([7,12,10],center=true);
        }
    }

    if(build == 1) translate([-2,-2,-2]) cube([200,200,16+2]);
    if(build == 2) translate([-2,-2,16]) cube([200,200,100]);
}


//OLED holder.
if((build == 0) || (build == 4))
difference(){
    translate([104.5-29,84.5/2,35+1]) screencover();
    translate([104.5-29,84.5/2,35]) rotate([0,0,270]) screencut();
}


// Bottom plate.
if((build == 0) || (build == 3))
translate([0,0,-10]){
    difference(){

// Block to cut the bottom plate from.
        union(){
            minkowski(){
                translate([2,2,0]) cube([100.5,80.5,3]);
                difference(){
                    sphere(2);
                    cylinder(h=10,d=10);
                }
            }
            translate([4.25,4.25]) cube([96,76,4]);
        }

// Cutout for a battery holder for 3xAA.
        translate([104.5-47,(84.5-58)/2,-19]){
            cube([47,58,20]);
            translate([47-12-3,58-3]) cube([3,3,40]);
            translate([8,58/2]) cylinder(h=40,d=2.3);
            translate([38,58/2]) cylinder(h=40,d=2.3);
        }

// Cutout for the pillars in the box
        translate([0,0,3]) for(i=[0:5]) translate(screwpattern[i]) cylinder(h=10,d=7.5);

// Screw holes.
        for(i=[0:5]) translate(screwpattern[i]) cylinder(h=10,d=3.2);

// Cutouts for screw heads.
        translate([0,0,-10]){
            translate([    0,   0]) cylinder(h=10,r=8.5);
            translate([52.25,   0]) cylinder(h=10,r=7);
            translate([104.5,   0]) cylinder(h=10,r=8.5);
            translate([    0,84.5]) cylinder(h=10,r=8.5);
            translate([52.25,84.5]) cylinder(h=10,r=7);
            translate([104.5,84.5]) cylinder(h=10,r=8.5);
        }

// Cutout for the BNC jack.
        translate([4,84.5/2,8]) cube([15,15,10], center=true);
        translate([104.5-4,84.5/2,8]) cube([15,15,10], center=true);
    }
}
}

// OLED cutout module
module screencut(){
    translate([-29/2,-27.5/2]) cube([29,27.5,2.5]);
    translate([-27/2,-19.5/2,2.5]) cube([27,19.5,2]);
    translate([-14/2,-27.5/2,2.5]) cube([14,27.5,2]);
    translate([-29/2,-10/2,-10]) cube([29,10,10]);
    translate([-12/2,(27.5/2)-4,-10]) cube([12,4,10]);
    translate([0,(19.5-12)/2-1]){
        hull(){
            translate([0,0,10]) cube([23,12,10],center=true);
            translate([0,0,20]) cube([23+10,12+10,10],center=true);
        }
            translate([0,0,2.5]) cube([23,12,5],center=true);
    }
    translate([-50,-50]) cube([100,100,1]);
    
    for(i=[90:90:360]) rotate([0,0,i]) translate([(27+7)/2,(27+7)/2]) cylinder(h=20,d=3.2);
    for(i=[90:90:360]) rotate([0,0,i]) translate([(27+7)/2,(27+7)/2,-10]) cylinder(h=20,d=2.8);
}

// OLED screen bump.
module screencover(){
    difference(){
        minkowski(){
            hull() for(i=[90:90:360]) rotate([0,0,i]) translate([(27+7)/2,(27+7)/2]) cylinder(h=1.5,d=7);
            sphere(4);
        }
        translate([-50,-50,-10]) cube([100,100,10]);
    }
}

// Screw pattern in a array for reuse.
screwpattern=  [[      3.5,     3.5],
                [    52.25,     3.5],
                [104.5-3.5,     3.5],
                [      3.5,84.5-3.5],
                [    52.25,84.5-3.5],
                [104.5-3.5,84.5-3.5]];
