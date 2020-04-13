
include <cyl_head_bolt.scad>;

$fn=100;
    
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
lug = 10;

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

module lenscover(){
    difference(){
        union()
        {
        translate([0,0,0]) cylinder(d=68.5,h=lens_total_w,center=false);
            translate([-3.7,-40,14]) cube([3.7,80,41]);
        }

        translate([0,-maxh/2-5,-lug]) cube([maxh/2+lug,maxh+lug,maxw1+lug]);
            
        translate([15,0,maxw1]) rotate([0,65,0]) cube([45,maxh+2*lug,45], center=true);

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
part8_h = 66.4; //60.3
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

module d22out()
{
            translate([0,0,0]) cylinder(d=part7_h,h=part7_w+lug,center=false);

            translate([0,0,part7_w]) cylinder(d=part8_h,h=part8_w+part8_w_plus,center=false);
            
    translate([part7_h/2-box_x,-box_y/2,box_upper]) cube([box_x,box_y,box_z]);
    
}

module d22()
{
    difference()
    {
        d22out();
        d22inner();
    }
}

//d22();

maxh=72;
maxw1=lens_total_w;
maxw2=part7_w;
d22offset = 7.53;

module 22dbase() {
    
    difference(){
        cube([maxh+20,maxh,maxw2]);
            
        //top tringle
        translate([maxh/2+4,-1,maxw2]) rotate([0,20,0]) cube([60,maxh+lug,40]);
        
        translate([maxh+15,-7,maxw2/2-2])
        rotate([0,0,30]) 
        cube([35,35,maxw2+lug], center=true );

        translate([maxh+15,maxh+7,maxw2/2-2])
        rotate([0,0,-30]) 
        cube([35,35,maxw2+lug], center=true );
    }
}

//22dbase();

module plate() {
    difference()
    {
        //whole cube
        union()
        {
            //lens
            hull(){
                translate([0,0,0]) cylinder(d=68.5,h=lens_total_w+10,center=false);
                //19 65 72
                translate([35,-(65+3)/2,9.3]) cube([20,65+3,72]);
            }
            //14 55 - 14 = 41
            translate([0,-40,14]) cube([3.7,80,41]);

            //22d
            translate([-maxh/2,-maxh/2,maxw1]) 22dbase();
            
        }
        
        
        translate([-maxh/2*0.9,-maxh/2*0.9,maxw1+10])
            difference()
        {
            scale([0.9,0.9,0.9]) 22dbase();
            translate([57,15,]) rotate([0,45,0]) cube([35,35,35]);

            translate([80,18,28]) difference(){
                cube([10,30,35]);
                translate([-1,3.0,10.0]) rotate([0,-90,0]) screw("M3x6");
                translate([-1,3.0,25.0]) rotate([0,-90,0]) screw("M3x6");
                translate([-1,25.0,25.0]) rotate([0,-90,0]) screw("M3x6");
                translate([-1,25.0,10.0]) rotate([0,-90,0]) screw("M3x6");
                
            }

        }
        
        //lens box
        difference()
        {
            translate([-maxh/2-lug,-maxh/2-5,-lug]) cube([maxh/2+lug,maxh+lug,maxw1+lug]);
            
            translate([15,0,maxw1]) rotate([0,65,0]) cube([45,maxh+2*lug,45], center=true);
        }
        translate([0,-37,19]) rotate([0,-90,0]) screw("M3x6");
        translate([0,-37,48]) rotate([0,-90,0]) screw("M3x6");
        translate([0,37,19]) rotate([0,-90,0]) screw("M3x6");
        translate([0,37,48]) rotate([0,-90,0]) screw("M3x6");
        

        //d22 box
        union(){
            translate([-maxh/2-lug-d22offset,-maxh/2-lug/2,-lug/2+maxw1]) cube([maxh/2+lug,maxh+lug,maxw2+lug]);    
            
            //side trinagle
            translate([-d22offset, maxh/2,-lug/2+maxw1+(maxw2+lug)/2]) rotate(45) cube([8.2,8.2,maxw2+lug],center=true);
            
            //side trinagle    
            translate([-d22offset,-maxh/2,-lug/2+maxw1+(maxw2+lug)/2]) rotate(45) cube([8.2,8.2,maxw2+lug], center=true);
        }

        //65 19 71
        translate([35,-65/2,0]) cube([19,65,(71+9.3)]);
        //65 19 71
        translate([40,10,63]) cube([20,20,15]);
        translate([36,-23,70]) cube([5,5,30]);
        
        lens();
        translate([0,0,lens_total_w]) d22out();


    }
}

plate();

/*
            scale([0.9,0.9,0.9]) 22dbase();
            translate([57,15,]) rotate([0,45,0]) cube([35,35,35]);
            %translate([80,18,28]) 

union(){
cube([10,30,35]);
translate([0,3.5,10.3]) rotate([0,-90,0]) screw("M3x6");
}
*/