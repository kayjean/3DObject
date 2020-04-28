
include <cyl_head_bolt.scad>;

$fn=200;
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
    translate([0,0,0]) cylinder(d=part1_h,h=part1_w,center=false);

    //old part2 translate([0,0,part1_w]) cylinder(d=part2_h,h=part2_w,center=false);
    
    translate([0,0,part1_w+part2_w]) cylinder(d=part3_1_h,h=part3_1_w+5,center=false);
    translate([0,0,part1_w+part2_w+part3_1_w]) cylinder(d=part3_2_h,h=part3_2_w,center=false);
    
    translate([0,0,part1_w+part2_w+(part3_1_w+part3_2_w)]) cylinder(d=part4_h,h=part4_w,center=false);
    translate([0,0,part1_w+part2_w+(part3_1_w+part3_2_w)+part4_w]) cylinder(d=part5_h,h=part5_w,center=false);
    translate([0,0,part1_w+part2_w+(part3_1_w+part3_2_w)+part4_w+part5_w]) cylinder(d=part6_h,h=part6_w+2,center=false);
    
}
//lens();

module lenscover()
{
    difference(){
        union()
        {
            //whole body
            hull() scale([1.06,1.06,1]) lens();
            //translate([0,0,0]) cylinder(d=lens_out_h,h=lens_total_w,center=false);
            
            //nutch plate
            translate([-3.7,-40,14]) cube([3.7,80,41]);
        }

        // another part
        translate([0,-d22box_y/2,0]) cube([d22box_y/2,d22box_y,maxw1]);

        //triangle
        translate([15,0,maxw1]) rotate([0,65,0]) cube([40,d22box_y,40], center=true);

        lens();

        //space for manual focus
        translate([-45,-25,40]) cube([20,50,14]);

        // 4 screw
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


//d22box_x=62.53;
//d22box_y=72;
d22box_x=72.53;
d22box_y=73;

maxw1=lens_total_w;
maxw2=part7_w;
d22offset = 7.53;

module 22dbase() {
    
    difference(){
        cube([d22box_x,d22box_y,maxw2]);
            
        //top tringle
        translate([d22box_x/2,-1,maxw2]) rotate([0,20,0]) cube([60,d22box_y+lug,40]);
        
        translate([d22box_x,-10,maxw2/2-2]) rotate([0,0,30]) cube([35,35,maxw2+lug], center=true );

        translate([d22box_x,d22box_y+10,maxw2/2-2])
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
            
            //flash
            translate([0,0,52])
                cube([d22box_x,d22box_y,3]);
        }
        
        //flash
        translate([37-20,  d22box_y/2-35/2  ,51])
                cube([26+20,35,6]);
        

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
                hull() scale([1.06,1.06,1]) lens();
                //battery
                //76 41 20
                translate([33,-(41+4)/2,8]) cube([20,41+4,76]);
            }
            
            //lens plate
            translate([0,-40,14]) cube([3.7,80,41]);

            //22d
            translate([-d22offset,-d22box_y/2,maxw1]) 22dinter();
            
            //for laptop
            translate([50,-5,88]) cube([15,10,10]);
        }

        //lens box
        difference(){
            translate([-d22box_y/2,-d22box_y/2-2,-2]) cube([d22box_y/2,d22box_y,maxw1+5]);
            
            translate([15,0,maxw1]) rotate([0,65,0]) cube([40,d22box_y,40], center=true);
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
        translate([33,-(41)/2,0]) cube([20,41,88]);        
        translate([33,9,8+76/2-4]) rotate([0,90,0]) screw("M3x6");
        translate([33,-9,8+76/2-4]) rotate([0,90,0]) screw("M3x6");

        //connect d22 and lens
        translate([44,-3,70]) cube([6,6,30]);
        
        //bottom
        translate([58,11.5,150]) rotate([0,-90,0]) screw("M3x6");
        translate([58,-11.5,150]) rotate([0,-90,0]) screw("M3x6");
        translate([58,11.5,164]) rotate([0,-90,0]) screw("M3x6");
        translate([58,-11.5,164]) rotate([0,-90,0]) screw("M3x6");

        
        translate([68,0,92]) rotate([0,90,0]) screw("M8x12");


        //flash
        translate([30,-28,170]) cube([30,57,2.7]);

    }
    
    //test
    //translate([55,-15,90]) cube([35,30,25]);
        
    
    //bottom
    translate([38,-32/2,91]) rotate([0,45,0]) cube([4,32,32]);
    
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

