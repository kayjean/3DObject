rotate_extrude(convexity = 10, $fn = 100)
translate([39, 67,0])
circle(r = 2, $fn = 100);
$fn=120;
difference(){
    translate([0,0,0])cylinder(r2=41, r1=41, h=67);
    translate([0,0,-1]) cylinder(r2=37, r1=37,h=69);
}
difference(){
    translate([0,0,0]) sphere(r=41);
    translate([0,0,0]) sphere(r=39);
    translate([-41,-41,0]) cube(82);
    translate([0,0,-35]) sphere(r=41);
}

difference(){
    translate([0,0,-17.5]) cylinder(r2=38, r1=37, h=4);
}

difference(){
    //    translate([0,0,-35]) sphere(r=41);
translate([0,0,-16.5])
rotate_extrude($fn = 300)
translate([35,0,0])
scale([1,4])
circle(d = 4, $fn = 100);    
    translate([-41,-41,-17.5]) cube(82);
}
