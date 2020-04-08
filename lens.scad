
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
    $fn=100;
    
    
    translate([0,0,-lug])
    cylinder(d=part1_h,h=part1_w+2*lug,center=false);
    translate([0,0,part1_w])
    cylinder(d=part2_h,h=part2_w+lug,center=false);
    translate([0,0,part1_w+part2_w])
    cylinder(d=part3_h,h=part3_w,center=false);
    translate([0,0,part1_w+part2_w+part3_w-lug])
    cylinder(d=part4_h,h=part4_w+2*lug,center=false);
    translate([0,0,part1_w+part2_w+part3_w+part4_w])
    cylinder(d=part5_h,h=part5_w,center=false);
    translate([0,0,part1_w+part2_w+part3_w+part4_w+part5_w-lug])
    cylinder(d=part6_h,h=part6_w+2*lug,center=false);
}

part7_w = 126;
part7_h = 59.42;

module d22()
{
    $fn=100;
    box_x = 40;
    box_y = 40;
    box_z = 40;
    cylinder(d=part7_h,h=part7_w+lug,center=false);
    translate([0,-box_y/2,0]) cube([box_x,box_y,box_z]);
}

maxh=85;
maxw1=lens_total_w;
maxw2=part7_w;
d22offset = 9.93;


difference()
{

    translate([-maxh/2,-maxh/2,0]) cube([maxh,maxh,maxw1+maxw2]);


        //lens box
    difference()
    {
    translate([-maxh/2-lug,-maxh/2-5,-lug]) cube([maxh/2+lug,maxh+lug,maxw1+lug]);
        
translate([15,0,maxw1])
        rotate([0,65,0]) 
        cube([45,maxh+2*lug,45], center=true);
        
        
    }

    
    translate([0,-(maxh-2*lug)/2,maxw1+lug]) cube([maxh/2-lug,maxh-2*lug,maxw2-3*lug]);



    //d22 box
    union(){
        translate([-maxh/2-lug-d22offset,-maxh/2-lug/2,-lug/2+maxw1]) cube([maxh/2+lug,maxh+lug,maxw2+lug]);    
        
        //6.0  8.2
        translate([-d22offset, maxh/2,-lug/2+maxw1+(maxw2+lug)/2]) rotate(45) cube([8.2,8.2,maxw2+lug],center=true);
            
        translate([-d22offset,-maxh/2,-lug/2+maxw1+(maxw2+lug)/2]) rotate(45) cube([8.2,8.2,maxw2+lug], center=true);
    }

    //top tringle
translate([maxh/2,0,maxw1+maxw2])
        rotate([0,45,0]) 
        cube([40,maxh+lug,40], center=true);

    
    lens();
    translate([0,0,lens_total_w]) d22();

}

