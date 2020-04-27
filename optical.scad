
$fn=200;

include <cyl_head_bolt.scad>;

difference()
{
    union()
    {
        //16.85
        cylinder(d=16.85,h=32,center=false);
        
        difference()
        {
        cylinder(d=28,h=8,center=false);
        translate([0,9.8,8]) screw("M3x10");
            translate([0,-9.8,8]) screw("M3x10");
            translate([9.8,0,8]) screw("M3x10");
            translate([-9.8,0,8]) screw("M3x10");
        }
    }
    
//11.95 -> 12
cylinder(d=12.3,h=32,center=false);
    
    
}