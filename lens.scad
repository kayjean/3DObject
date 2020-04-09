
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

    //part2 , have to put here unknown reason
    translate([0,0,part1_w]) rotate_extrude(angle=360, convexity=10, $fn = 100)
    polygon(points=[[0,0],[0,part2_w],[part3_h/2,part2_w],[part1_h/2,0]]);
    
    //part1
    translate([0,0,-1]) cylinder(d=part1_h,h=part1_w+lug,center=false);

    //old part2 translate([0,0,part1_w]) cylinder(d=part2_h,h=part2_w,center=false);
    
    translate([0,0,part1_w+part2_w]) cylinder(d=part3_h,h=part3_w,center=false);
    translate([0,0,part1_w+part2_w+part3_w-lug]) cylinder(d=part4_h,h=part4_w+2*lug,center=false);
    translate([0,0,part1_w+part2_w+part3_w+part4_w]) cylinder(d=part5_h,h=part5_w,center=false);
    translate([0,0,part1_w+part2_w+part3_w+part4_w+part5_w-lug]) cylinder(d=part6_h,h=part6_w+2*lug,center=false);
    
}




part7_w = 126;
part7_h = 60.0;
part7_wall = 3.0;

part8_w = 13.22;
part8_h = 63.0;
part8_wall = 3.0;

module d22()
{
    
    
    difference()
    {
            $fn=100;
            box_x = 8.7;
            box_y = 35;
            box_z = 34;
            box_upper = 3.5;
        
        union()
        {
            
            translate([0,0,0]) cylinder(d=part7_h,h=part7_w+lug,center=false);
            
            translate([0,0,part7_w]) cylinder(d=part8_h,h=part8_w,center=false);
            
            translate([part7_h/2-box_x,-box_y/2,box_upper]) 
                cube([box_x,box_y,box_z]);
        }
        union()
        {
            translate([0,0,-1]) cylinder(d=part7_h-2*part7_wall,h=part7_w+lug,center=false);
            
            translate([0,0,part7_w]) cylinder(d=part8_h-2*part8_wall,h=part8_w+lug,center=false);
            
        }
        
            translate([part7_h/2-box_x,-box_y/2,box_upper]) 
                translate([box_x/2,box_z/2,box_z/2]) 
                rotate([0,90,0]) cylinder(d=30,h=box_x+lug,center=true);

    translate([-40,-21,-lug]) cube([50,42,38+lug]);
        
    }
}

d22();

/*
maxh=77;
maxw1=lens_total_w;
maxw2=part7_w;
d22offset = 7.53;



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
    translate([0,0,lens_total_w]) hull() d22();

}
*/