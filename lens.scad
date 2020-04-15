
include <cyl_head_bolt.scad>;

$fn=100;
lug = 10;

//lens inner
part1_w = 5.7;
part1_h = 58.15;
part2_w = 2.0;
part2_h = 60;
part3_w = 48;
part3_h = 61.13;
part4_w = 10.6;
part4_h = 53.92;
part5_w = 8.9;
part5_h = 60.24;
part6_w = 8.1;
part6_h = 56.04;
lens_total_w = part1_w+part2_w+part3_w+part4_w+part5_w+part6_w;

//lens putter
lens_out_h = 68.5;

module lens()
{
    //part2 , have to put here unknown reason
    translate([0,0,part1_w]) rotate_extrude(angle=360, convexity=10, $fn = 100) polygon(points=[[0,0],[0,part2_w],[part3_h/2,part2_w],[part1_h/2,0]]);
    
    //part1
    translate([0,0,-1]) cylinder(d=part1_h,h=part1_w+lug,center=false);

    //old part2 translate([0,0,part1_w]) cylinder(d=part2_h,h=part2_w,center=false);
    
    translate([0,0,part1_w+part2_w]) cylinder(d=part3_h,h=part3_w,center=false);
    translate([0,0,part1_w+part2_w+part3_w-lug]) cylinder(d=part4_h,h=part4_w+2*lug,center=false);
    translate([0,0,part1_w+part2_w+part3_w+part4_w]) cylinder(d=part5_h,h=part5_w,center=false);
    translate([0,0,part1_w+part2_w+part3_w+part4_w+part5_w-lug]) cylinder(d=part6_h,h=part6_w+2*lug,center=false);
    
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
part8_w_plus = 5.00;
part8_h = 68.4; //60.3
part8_wall = 3.0;

box_x = 8.7;
box_y = 35;
box_z = 34;
box_upper = 3.5;

module d22inner()
{
        union()
        {
            translate([0,0,-1]) cylinder(d=part7_h-2*part7_wall,h=part7_w,center=false);
            
            translate([0,0,part7_w+2]) cylinder(d=part8_h-2*part8_wall,h=part8_w+lug,center=false);

            translate([0,0,part7_w-2]) cylinder(d=part7_h-2*6.4,h=part8_w,center=false);
            
        }
        
        translate([part7_h/2-box_x,-box_y/2,box_upper]) translate([box_x/2,box_z/2,box_z/2]) rotate([0,90,0]) cylinder(d=30,h=box_x+lug,center=true);

        translate([-40,-21,-lug]) cube([50,42,38+lug]);
        
        translate([part8_h/2,0,part7_w+part8_w+part8_w_plus/2-1]) rotate([0,90,0]) screw("M3x6");
        translate([-part8_h/2,0,part7_w+part8_w+part8_w_plus/2-1]) rotate([0,-90,0]) screw("M3x6");
        translate([0,-part8_h/2,part7_w+part8_w+part8_w_plus/2-1]) rotate([90,0,0]) screw("M3x6");
        translate([0,part8_h/2,part7_w+part8_w+part8_w_plus/2-1]) rotate([-90,0,0]) screw("M3x6");
    
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
        d22inner();
    }
}

//translate([0,0,-145]) d22();

module mirror()
{
    translate([12.7,0,12.7*2-5])
    rotate([90,0,0])
    union()
    {

        difference(){
            cylinder(2,54/2,54/2);
            translate([0,0,-1]) cylinder(6,12.7,12.7);
        }

        difference(){
            translate([0,0,2]) cylinder(2,49/2,49/2);
            translate([-13,-13,-1]) cube(26);
        }
    }
    
        difference(){
    
    hull()
    {
        linear_extrude(height = 41.6, center = false, convexity = 10, twist = 0) polygon(points=[[0,0],[38,38],[38,0]]);
        translate([41,10,10]) cube( [10,20,20]);
                
        }
            translate([-1,-1,5]) linear_extrude(height = 31.2, center = false, convexity = 10, twist = 0) polygon(points=[[0,0],[30,30],[30,0]]);    

        
    }

}

//mirror();

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
        translate([d22box_x/20,d22box_y/20,maxw2/20]) scale([0.9,0.9,0.9]) 22dbase();

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
        translate([31,-65/2,0]) cube([21,65,80.3]);
        //bottom hole

        translate([40,13,20]) cube([80,14,55]);
        translate([40,-9,20]) cube([80,14,55]);
        translate([40,-29,20]) cube([80,14,55]);
        
        translate([20,4,20]) cube([20,16,55]);
        translate([20,-20,20]) cube([20,16,55]);

        //connect d22 and lens
        translate([36,-23,70]) cube([5,5,30]);
        
        //bottom
        translate([48,11,130]) rotate([0,-90,0]) screw("M3x6");
        translate([48,-11,130]) rotate([0,-90,0]) screw("M3x6");
        translate([48,11,144]) rotate([0,-90,0]) screw("M3x6");
        translate([48,-11,144]) rotate([0,-90,0]) screw("M3x6");
                
    }
    
    //bottom
    translate([29,-32/2,89]) rotate([0,45,0]) cube([4,32,32]);
    
}
plate();

