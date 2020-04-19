
include <cyl_head_bolt.scad>;

$fn=100;
lug = 10;

//lens inner
part1_w = 5.7;
part1_h = 58.15;
part2_w = 2.0;
part2_h = 60;
part3_1_w = 32;
part3_1_h = 61.13;
part3_2_w = 16;
part3_2_h = 62.5;
part4_w = 10.6;
part4_h = 53.92;
part5_w = 8.9;
part5_h = 60.24;
part6_w = 8.1;
part6_h = 56.04;
lens_total_w = part1_w+part2_w+part3_1_w+part3_2_w+part4_w+part5_w+part6_w;

//lens putter
lens_out_h = 68.5;

module lens()
{
    //part2 , have to put here unknown reason
    translate([0,0,part1_w]) rotate_extrude(angle=360, convexity=10, $fn = 100) polygon(points=[[0,0],[0,part2_w],[part3_1_h/2,part2_w],[part1_h/2,0]]);
    
    //part1
    translate([0,0,-1]) cylinder(d=part1_h,h=part1_w+lug,center=false);

    //old part2 translate([0,0,part1_w]) cylinder(d=part2_h,h=part2_w,center=false);
    
    translate([0,0,part1_w+part2_w]) cylinder(d=part3_1_h,h=part3_1_w+5,center=false);
    translate([0,0,part1_w+part2_w+part3_1_w]) cylinder(d=part3_2_h,h=part3_2_w,center=false);
    
    translate([0,0,part1_w+part2_w+(part3_1_w+part3_2_w)-1.5*lug]) cylinder(d=part4_h,h=part4_w+3*lug,center=false);
    translate([0,0,part1_w+part2_w+(part3_1_w+part3_2_w)+part4_w]) cylinder(d=part5_h,h=part5_w,center=false);
    translate([0,0,part1_w+part2_w+(part3_1_w+part3_2_w)+part4_w+part5_w-lug]) cylinder(d=part6_h,h=part6_w+2*lug,center=false);
    
}
//lens();

module lenscover()
{
    difference(){
        union()
        {
            
            translate([0,0,0]) cylinder(d=lens_out_h,h=lens_total_w,center=false);
            //nutch plate
            translate([-3.7,-40,14]) cube([3.7,80,41]);
        }

        translate([0,-d22box_y/2-5,-lug]) cube([d22box_y/2+lug,d22box_y+lug,maxw1+lug]);
            
        translate([15,0,maxw1]) rotate([0,65,0]) cube([40,d22box_y+2*lug,40], center=true);

        lens();

        //40 54
        translate([-45,-25,40]) cube([20,50,14]);
        
        translate([0,-37,19]) rotate([0,90,0]) screw("M3x6");
        translate([0,-37,48]) rotate([0,90,0]) screw("M3x6");
        translate([0,37,19]) rotate([0,90,0]) screw("M3x6");
        translate([0,37,48]) rotate([0,90,0]) screw("M3x6");
        
    }
}

//lenscover();



part7_w = 126;
part7_h = 58.3; //52.3
part7_wall = 3.0;

part8_w = 19.00;
part8_w_plus = 10.00;
part8_h = 68.4; //60.3
part8_wall = 3.0;

box_x = 8.7;
box_y = 35;
box_z = 34;
box_upper = 3.5;


module mirror()
{
    //round
    translate([16.5,2,20])
    rotate([90,0,0])
    difference(){
        union()
        {
                cylinder(2,55/2,55/2);
                translate([0,0,2]) cylinder(2,49/2,49/2);
        }
        translate([0,0,-2]) cylinder(16,12.5,12.5);
        translate([-12.5,-12.5,1]) cube([25,25,5]);
    }
    
    //tringle
    difference(){
        union()
        {
        hull()
        {
            linear_extrude(height = 41.5, center = false, convexity = 10, twist = 0) polygon(points=[[0,0],[40,40],[40,0]]);
            translate([41,0,10]) cube( [10,40,20]);
        }
        
    translate([0,0,-5]) linear_extrude(height = 5, center = false, convexity = 10, twist = 0) polygon(points=[[0,0],[27,27],[27,0]]);    
        
    translate([0,0,40]) linear_extrude(height = 5, center = false, convexity = 10, twist = 0) polygon(points=[[0,0],[27,27],[27,0]]);    
        
    }
    translate([0,0,-5]) linear_extrude(height = 5, center = false, convexity = 10, twist = 0) polygon(points=[[0,0],[5,5],[5,0]]);    
    translate([0,0,40]) linear_extrude(height = 5, center = false, convexity = 10, twist = 0) polygon(points=[[0,0],[5,5],[5,0]]);    
        
        translate([35,37.5,-5]) cube( [20,20,50]);
        
        translate([0,0,5]) linear_extrude(height = 31.2, center = false, convexity = 10, twist = 0) polygon(points=[[0,0],[30,30],[30,0]]);
    
    
        translate([21,21,0]) rotate([0,90,135]) screw("M3x5");
        translate([8,8,0]) rotate([0,90,135]) screw("M3x5");
        translate([21,21,40]) rotate([0,90,135]) screw("M3x5");
        translate([8,8,40]) rotate([0,90,135]) screw("M3x5");
    
    }
    
    
}
//mirror();


module d22inner()
{
        union()
        {
            translate([0,0,0]) cylinder(d=part7_h-2*part7_wall,h=part7_w,center=false);
            
            
            translate([0,0,part7_w+2]) cylinder(d=part8_h-2*part8_wall,h=part8_w+lug,center=false);

            translate([0,0,part7_w-2]) cylinder(d=part7_h-2*6.4,h=part8_w,center=false);
            
        }

        //4 srews
        translate([part8_h/2,0,part7_w+part8_w+part8_w_plus/2]) rotate([0,90,0]) screw("M5x10");
        translate([-part8_h/2,0,part7_w+part8_w+part8_w_plus/2]) rotate([0,-90,0]) screw("M5x10");
        translate([0,-part8_h/2,part7_w+part8_w+part8_w_plus/2]) rotate([90,0,0]) screw("M5x10");
        translate([0,part8_h/2,part7_w+part8_w+part8_w_plus/2]) rotate([-90,0,0]) screw("M5x10");

        // lens
        translate([part7_h/2-box_x,-box_y/2,box_upper]) translate([box_x/2,box_z/2,box_z/2]) rotate([0,90,0]) cylinder(d=30,h=box_x+lug,center=true);
}
//d22inner();

module d22out()
{
            translate([0,0,0]) cylinder(d=part7_h,h=part7_w+lug,center=false);

            translate([0,0,part7_w]) cylinder(d=part8_h,h=part8_w+part8_w_plus,center=false);
            
    translate([part7_h/2-box_x,-box_y/2,box_upper]) cube([box_x,box_y,box_z]);
    
}

//d22out();

module d22()
{
    difference()
    {
        d22out();
        
        //mirror
        translate([16.4,-20,2]) rotate([90,0,180]) mirror();
        translate([16.4,-20,2]) rotate([90,0,180]) translate([20,-10,0]) cube( [50,20,41.5]);

        //special for cut for mirror
        translate([0,0,-8]) cylinder(d=55,h=10,center=false);
        
        d22inner();
    }
}

//d22();


d22box_x=62.53;
d22box_y=72;

maxw1=lens_total_w;
maxw2=part7_w;
d22offset = 7.53;

module 22dbase() {
    
    difference(){
        cube([d22box_x,d22box_y,maxw2]);
            
        //top tringle
        translate([d22box_x/2,-1,maxw2]) rotate([0,20,0]) cube([60,d22box_y+lug,40]);
        
        translate([d22box_x,-7,maxw2/2-2])
        rotate([0,0,30]) 
        cube([35,35,maxw2+lug], center=true );

        translate([d22box_x,d22box_y+7,maxw2/2-2])
        rotate([0,0,-30]) 
        cube([35,35,maxw2+lug], center=true );
        
        //side trinagle
        translate([0, 0,(-lug+maxw2)/2]) rotate(45) cube([8.2,8.2,maxw2+lug*2],center=true);
        translate([0, d22box_y,(-lug+maxw2)/2]) rotate(45) cube([8.2,8.2,maxw2+lug*2],center=true);

    }
}

//22dbase();

module 22dinter()
{
    difference()
    {
        //22d
        22dbase();
        
        difference()
        {
        translate([d22box_x/20,d22box_y/20,maxw2/20]) scale([0.9,0.9,0.9]) 22dbase();
            
            translate([0,0,40])
                cube([60,80,3]);
        }

    }
}
//22dinter();



module plate() {
    difference()
    {
        //whole cube
        union()
        {
            //lens and battery
            hull(){
                translate([0,0,0]) cylinder(d=68.5,h=lens_total_w,center=false);
                //battery
                translate([35,-(65+3)/2,12]) cube([20,65+3,72]);
            }
            
            //lens plate
            translate([0,-40,14]) cube([3.7,80,41]);

            //22d
            translate([-d22offset,-d22box_y/2,maxw1]) 22dinter();
            
            
            translate([40,-5,88]) cube([15,10,10]);
        }

        //lens box
        difference(){
            translate([-d22box_y/2-lug,-d22box_y/2-5,-lug+1]) cube([d22box_y/2+lug,d22box_y+lug,maxw1+lug]);
            
            translate([15,0,maxw1]) rotate([0,65,0]) cube([40,d22box_y+2*lug,40], center=true);
        }
        
        translate([0,-37,19]) rotate([0,-90,0]) screw("M3x6");
        translate([0,-37,48]) rotate([0,-90,0]) screw("M3x6");
        translate([0,37,19]) rotate([0,-90,0]) screw("M3x6");
        translate([0,37,48]) rotate([0,-90,0]) screw("M3x6");
        
        union()
        {
            lens();
            translate([0,0,lens_total_w]) d22out();
        }
        
        //battery
        //big hole
        translate([33,-65/2,0]) cube([25,65,80.3]);
        translate([43,65/2,30]) rotate([270,0,0]) screw("M3x6");
        translate([43,65/2,60]) rotate([270,0,0]) screw("M3x6");
        translate([43,-65/2,30]) rotate([90,0,0]) screw("M3x6");
        translate([43,-65/2,60]) rotate([90,0,0]) screw("M3x6");

        //connect d22 and lens
        translate([36,-23,70]) cube([5,5,30]);
        
        //bottom
        translate([48,11.5,130]) rotate([0,-90,0]) screw("M3x6");
        translate([48,-11.5,130]) rotate([0,-90,0]) screw("M3x6");
        translate([48,11.5,144]) rotate([0,-90,0]) screw("M3x6");
        translate([48,-11.5,144]) rotate([0,-90,0]) screw("M3x6");

        
        translate([56,0,92]) rotate([0,90,0]) screw("M8x12");

    }
    
    //bottom
    translate([29,-32/2,89]) rotate([0,45,0]) cube([4,32,32]);

    
}
plate();

/*
difference()
{
    plate();
    translate([-10,-50,-2]) cube([100,100,84]);
    translate([-10,-50,100]) cube([100,100,700]);    
    translate([-10,8,-2]) cube([100,100,184]);
    translate([-10,-40,-2]) cube([100,32,184]);
}
*/


/****************************
 * Generate Headset for 22D *
 ****************************/

// TODO: Lens flange slots don't actually allow the lenses to rotate into them.

/*******************************
 *   Adjustable Measurements   *
 *                             *
 * All measurements are in mm. *
 *******************************/

// Overall case size
// Width, Depth, Height
//CaseSize = [140, 42, 75];
CaseSize = [160, 25, 80];

// Interpupillary Distance
IPD = 75;

// Diameter of the lenses at the eyes
LensDiameter = 34;

// Width, Thickness, and Height of the 
// protrusions on the lens that latch onto the frame.
LensFlangeDimensions = [11, 2.5, 4];

// Distance the lens is inset into the frame
LensFlangeInset = 1;

// Number of flanges around the edges of the lens
NumberOfLensFlanges = 3;

// Nose Opening measurements
// Width, depth, height
NoseOpening = [35, 40, 40]; 

// Face Guard measurements
FaceGuardDepth = 50;
FaceGuardThickness = 1;

///////////////////////////
// Internal Measurements //
//     DO NOT CHANGE     //
///////////////////////////

// Derived lens measurements
HalfIPD = IPD / 2;
LensRadius = LensDiameter / 2;

// Distance from the bottom of the case 
// that indicates where the center of the lenses should be.
LensVerticalDistance = 75/2;

CenterLeftLens = [
    CaseSize.x / 2 - HalfIPD, 
    LensVerticalDistance];
CenterRightLens = [
    CaseSize.x / 2 + HalfIPD, 
    LensVerticalDistance];
   
LensFlangeOpeningDimensions = [
    LensFlangeDimensions.x,
    LensFlangeDimensions.y + LensFlangeInset,
    LensFlangeDimensions.z
];
    
// Derived nose opening measurements
NoseOpeningRatio = NoseOpening.y/NoseOpening.x;


// Derived face guard measurements
FaceGuard = [CaseSize.x, FaceGuardDepth, CaseSize.z];
FaceGuardInterior = [
    CaseSize.x - FaceGuardThickness * 2, 
    FaceGuardDepth + 2, 
    CaseSize.z - FaceGuardThickness * 2];
FaceGuardArcRadius = FaceGuardInterior.x / 2;

// Total size of the headset
TotalSize = [
    CaseSize.x,
    CaseSize.y + FaceGuard.y,
    CaseSize.z
];

// Dump key measurements to console for generating Cardboard profile
echo("Key Measurements for Cardboard Profile:");
echo(ScreenToLensDistance=CaseSize.y - 2);
echo(InterLensDistance=IPD); 
//echo(TrayToLensCenterDistance=LensVerticalDistance);

// Modules
module flattenedTube(size) {
    intersection() {
        cube(size);
        rotate ([-90, 0, 0]) {
            translate([size.x / 2, -size.z / 2, 0]) {
                cylinder(h=size.y, d=size.x, $fa=6);
            }
        }
    }
}

module masklens() {
    rotate ([-90, 0, 0]) {
        cylinder(h=CaseSize.y+0.01, 
                 d1=LensDiameter, 
                 $fa=6);
    }

    for (i = [0:360/NumberOfLensFlanges:360]) {
        rotate([0, i, 0]) {
            // Flange opening
            translate([-(LensFlangeOpeningDimensions.x / 2), 0, LensRadius - LensFlangeOpeningDimensions.z]) {
                cube([
                    LensFlangeOpeningDimensions.x,
                    LensFlangeOpeningDimensions.y,
                    LensFlangeOpeningDimensions.z * 2]);
            }
            // Flange slot
            slotRotation = atan((LensFlangeDimensions.x / 2) / (LensRadius + LensFlangeDimensions.z)) * 2;
            rotate([0, -slotRotation, 0]) {
                translate([-(LensFlangeDimensions.x / 2), LensFlangeInset, (LensRadius) - LensFlangeOpeningDimensions.z]) {
                
                    cube([
                        LensFlangeDimensions.x,
                        LensFlangeDimensions.y,
                        LensFlangeDimensions.z * 2]);
                }
            }
        }
    }
}

module masklens2() {
    rotate ([-90, 0, 0]) {
        cylinder(h=CaseSize.y+0.01, 
                 d1=LensDiameter, 
                 $fa=6);
    }

    for (i = [0:360/NumberOfLensFlanges:360]) {
        rotate([0, i, 0]) {
            // Flange opening
            translate([-(LensFlangeOpeningDimensions.x / 2), 0, LensRadius - LensFlangeOpeningDimensions.z]) {
                cube([
                    LensFlangeOpeningDimensions.x,
                    LensFlangeOpeningDimensions.y,
                    LensFlangeOpeningDimensions.z * 2]);
            }
            // Flange slot
            slotRotation = atan((LensFlangeDimensions.x / 2) / (LensRadius + LensFlangeDimensions.z)) * 2;
            rotate([0, -slotRotation, 0]) {
                translate([-(LensFlangeDimensions.x / 2), LensFlangeInset, (LensRadius) - LensFlangeOpeningDimensions.z]) {
                
                    cube([
                        LensFlangeDimensions.x,
                        LensFlangeDimensions.y,
                        LensFlangeDimensions.z * 2]);
                }
            }
        }
    }
}


module noseHole() {
    scale([1, NoseOpeningRatio, 1]) {
         union() {
            cylinder(h=NoseOpening.z - 5, 
                     d1=NoseOpening.x, 
                     d2=10);
        }
        translate([0, 0, NoseOpening.z - 7.1]) {
            sphere(d=11);
        }
    }
}


module faceGuard() {
    difference() {
        flattenedTube(FaceGuard);
        // Hollow out the inside of the face guard
        translate([FaceGuardThickness, -1, FaceGuardThickness]) {
            flattenedTube(FaceGuardInterior);
        }
        // Arc at the top and bottom
        translate([FaceGuardArcRadius + FaceGuardThickness, -FaceGuardArcRadius + FaceGuard.y, 0]) {
            cylinder(h=FaceGuard.z, r=FaceGuardArcRadius);
        }
        // Nose Opening Cutout
        translate([(FaceGuard.x / 2) - (NoseOpening.x / 2), 0, 0]) {
            cube([NoseOpening.x, FaceGuard.y, FaceGuardThickness]);
        }
    }
}

// Case
module finalcase()
{
intersection() {
    union() {
        // Lens Holder
        difference() {
            cube(CaseSize);
            
            
            // Left Lens
            translate([CenterLeftLens.x, 40, CenterLeftLens.y]) {
                rotate([90,0,0]) cylinder(h=50, d=70);
                //masklens2();
            }
            
/*
            // Left Lens
            translate([CenterLeftLens.x, 0, CenterLeftLens.y]) {
                masklens();
            }
            
            // Right Lens
            translate([CenterRightLens.x, 0, CenterRightLens.y]) {
                masklens();
            }
*/
            
/*            
translate([37, 155, 38])
rotate([0,90,-90])
translate([0,0,-lens_total_w])
    union()
{
            //22d
            //translate([-d22offset,-d22box_y/2,maxw1]) 22dinter();

            translate([0,0,lens_total_w]) d22out();
}
*/

            
            // Nose hole
            translate([CaseSize.x / 2, 0, 0]) {
                noseHole();
            }
        }
        
        // Face Guard
        translate([0, -FaceGuard.y, 0]) {
            faceGuard();
        }
        
    }

    translate([0, -FaceGuard.y, 0]) {
        flattenedTube(TotalSize);
    }

}
}

//finalcase();

/*
difference()
{
finalcase();
translate([90,-150,-10]) cube([80,230,100]);    
    
//translate([0,-150,-10]) cube([90,230,100]);    
//translate([90,5,-10]) cube([80,100,100]);    

}
*/