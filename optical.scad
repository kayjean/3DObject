use <LEGO.scad>;

$fn=200;

include <cyl_head_bolt.scad>;
/*
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
*/


difference()
{

union()
{

        //16.85
        cylinder(d=16.85,h=32,center=false);


//44.63
difference()
{
cylinder(d=47,h=32,center=false);
cylinder(d=45.5,h=32,center=false);
}


cylinder(d=28,h=8,center=false);
difference()
{
translate([0,0,3]) cylinder(d=47,h=2,center=false);
translate([20,0,5]) cube(10 , center=true);
rotate(120,0,0) translate([20,0,5]) cube(10 , center=true);
rotate(240,0,0) translate([20,0,5]) cube(10 , center=true);
}

translate([-27.5,0,15])
rotate([0,90,0] )
block(
        type="tile",
        width=3,
        length=3
    );

}


//11.95 -> 12
cylinder(d=12.5,h=32,center=false);
        
}


