include <cyl_head_bolt.scad>;

$fn=120;

// Overall case size
// Width, Depth, Height
//CaseSize = [140, 42, 75];
//kayjean
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

module d22()
{
            translate([CenterLeftLens.x, 40, CenterLeftLens.y]) {
                rotate([90,0,0]) cylinder(h=50, d=70);
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
            

            // Left d22
            d22();

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
//finalcase();
//translate([90,-150,-10]) cube([80,230,100]);    
    
//translate([0,-150,-10]) cube([90,230,100]);    
//translate([90,5,-10]) cube([80,100,100]);    

}
*/

d22boxwidth = 70;



//eyeball
module eyeball( showbasescrew = false )
{
    if( showbasescrew == true)
    {
        translate([35,35,3]) screw("M3x8");
        translate([35,-5,3]) screw("M3x8");
        translate([-5,-5,3]) screw("M3x8");
        translate([-5,35,3]) screw("M3x8");
    }
        
    difference()
    {
        union()
        {
        cube([30, 30, 30]);
            translate([15,15,0]) cylinder(d=d22boxwidth,h=3,center=false);
        }
        
translate([1.5,1.5,0]) scale([0.9,0.9,0.9])        cube([30, 30, 30]);
        
        
        translate([15,15,36]) sphere(10);

            if( showbasescrew == false )
            {
        translate([35,35,4]) screw("M3x5");
        translate([35,-5,4]) screw("M3x5");
        translate([-5,-5,4]) screw("M3x5");
        translate([-5,35,4]) screw("M3x5");
            }


        translate([25,25,31]) screw("M3x5");
        translate([25,5,31]) screw("M3x5");
        translate([5,5,31]) screw("M3x5");
        translate([5,25,31]) screw("M3x5");
        
    }
    
}
//eyeball( showbasescrew = false);

module eyeballcover()
{
    difference()
    {
        cube([30, 30, 3]);
        translate([15,15,9]) sphere(10);
        
        translate([25,25,4]) screw("M3x5");
        translate([25,5,4]) screw("M3x5");
        translate([5,5,4]) screw("M3x5");
        translate([5,25,4]) screw("M3x5");
        
    }
}
eyeballcover();

module eyemount()
{
    difference()
    {
        heightdata = 80;
        cube([80, heightdata, 80]);
                    translate([40, heightdata-3, 40]) {
                        rotate([90,0,0]) cylinder(h=heightdata, d=d22boxwidth);
                    }
                    
        translate([25,heightdata-3,25]) rotate([90,0,0]) eyeball( showbasescrew = true );

    }
}

//eyemount();

