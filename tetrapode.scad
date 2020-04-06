$fa = 1;
$fs = 0.01;
build_size = 25;

module Kegelstumpf(size)
{
	union(){
        translate([0, 0, 4]) cylinder(h = size*1.2, r1 = size/2, r2 = (size/2)*0.65, center = false, $fn=6);
		translate([0, 0, size*1.25]) cylinder(h = size*0.3, r1 = (size/2)*0.75, r2 = (size/2)*0.85, center = false , $fn=6);
	}
}

module tetrapode(size)
{
	translate([0, 0, size*0.77])
	union() {
		rotate([0,0,0])
			Kegelstumpf(size);
		rotate([0,109.47,0])
			Kegelstumpf(size);
		rotate([0,109.47,120])
			Kegelstumpf(size);
		rotate([0,109.47,240])
			Kegelstumpf(size);
	}
}
tetrapode(build_size);
