/*
Decora Switch Extension
Chris Whiteford

Based on https://github.com/danmarshall/openscad-decora-switch-extension

Also using some of the techniques and code from http://www.nothinglabs.com/puzzlecut-openscad-library/
*/


//You'll need the sliding-bolt.scad file from https://github.com/danmarshall/openscad-sliding-bolt in the same directory as this file as its used to generate a major part of the item
use <slide.scad>;

buildSwitch = true;
buildExtension = false;
buildHandle = false;

inner_radius = 7;
travel = 35;
spacing = 96.8375;
height = 6;
standoff = 7;
decora_switch_face = 2;

extension_length = 150;
handle_radius = 500;

use_handle = false;
handle_length = 13;
handle_height = 8;
handle_fillet = 3;
handle_radius = 4;



module main() {
	$fn = 25;
	
	outer_radius = height / 2 + inner_radius + 1.5;
	square = 2 * outer_radius;

	module tcube(x, y, z, tx = 0, ty = 0, tz = 0) {
		translate([tx, ty, tz]) {
			cube([x, y, z]);
		}
	}

	module ccube(x, y, z, ty, tz) {
		tcube(x, y, z, -x / 2, ty, tz);
	}

	module mirror2(v = [1, 0, 0]) {
		children();
		mirror(v) {
			children();
		}
	}

	module slider(action) {
		slidingbolt(travel, inner_radius, height, 1, 0.3, 2, 2.6, standoff, action);
	}

	module roundedslidertracks() {
		difference() {
			union() {
				translate([-outer_radius, -outer_radius, 0]) {
					cube([square, travel + outer_radius + spacing, height]);
				}

				translate([0, spacing + travel, 0]) {
					cylinder(r = outer_radius, h = height);
				}
			}

			slider("track");

			translate([0, spacing, 0]) {
				slider("track");
			}
		}
	}

	module slidemount() {
		rotate([0, 0, 180]) {
			translate([0, outer_radius, 0]) {
				roundedslidertracks();

				translate([0, travel, 0]) {
					slider("bolt");
				}

				translate([0, spacing, 0]) {
					slider("bolt");
				}
			}
		}
	}

	module decoratouch() {
		r = standoff - decora_switch_face + 1;
		translate([0, 0, height]) {
			rotate([0, 90, 0]) {
				cylinder(h = square, r = r, center = true);
			}
		}
	}

	module handle() {
		translate([0, handle_height, 0]) {
			difference() {
				ccube(square + 2 * handle_fillet, handle_fillet + 1, height);

				mirror2() {
					translate([outer_radius + handle_fillet, 0, 0]) {
						cylinder(r = handle_fillet, h = height);
					}
				}
			}
			hull() {
				mirror2() {
					translate([outer_radius + handle_length, handle_fillet + handle_radius, 0]) {
						cylinder(r = handle_radius, h = height);
					}
				}
			}
		}
		ccube(square, handle_height + 1, height, -.01);
	}
    
    module connector(type=1, cutLocations = [0]) {
        if (type == 0)
        {
            //Female connector
            xFemaleCut(cutLocations=cutLocations, cutSize = 15, kerf=-0.10) children([0]);
        }
        else
        {
            //Male connector
            xMaleCut(cutLocations=cutLocations, cutSize = 15) children([0]);
        }
        
    }
    
    
    module xFemaleCut(offset = 0, cutLocations = [], cutSize = 4, kerf = 0)
    {
        intersection()
        {
            children([0]);            
            translate([0,offset,0]) makePuzzleStamp(kerf = kerf, cutSize = cutSize, cutLocations = cutLocations);	//only set kerf on female side
        }
    }
    
    module xMaleCut(offset = 0, cutLocations = [], cutSize = 4)
    {
        difference()
        {
            children([0]); 	
            translate([0,offset,0]) makePuzzleStamp(cutSize = cutSize, cutLocations = cutLocations);
        }
    }
    
    module makePuzzleStamp(kerf = 0, cutSize = 4, cutLocations = [])
    {
        stampSize = [500,500,500];
        
        difference()
        {
            //make the cube
            translate ([0,stampSize[0] / 2 - kerf,0])
                cube (stampSize, center = true);
            
            //make the cuts
            for ( i = cutLocations )
            {
                translate([i,0,0])
                    cube ([(cutSize / 2) - kerf * 2, cutSize - kerf * 2,stampSize[2]], center = true);
                
                translate([i,cutSize / 1.5,0])
                    cube ([cutSize - kerf *  2,(cutSize / 2) - kerf * 2, stampSize[2]], center = true);
            }		
        }
    }


    if (buildSwitch) {
        //Build the main switch body (this gets attached to the switchplate)
        translate([0, outer_radius + travel + (spacing - travel) / 2, 0]) {
            slidemount();
            
            if (use_handle) {
                handle();
            }
            else {
                connector(type=1) {
                    translate([-(square/2),0,0])
                    {
                        cube([square,20,height]);
                    }
                }
            }
        }

        decoratouch();
    }
    else if (buildExtension) {
        connector(type=1) {
            translate([0,-extension_length,0]) {
                connector(type=0) {
                    translate([-(square/2),0,0]) {
                        cube([square,extension_length + 15,height]);
                    }
                }
            }
        }
    }
    else if (buildHandle) {
        union() {
            translate([0,50,0]) {
                rotate([180,0,0]) {
                    connector(type=0) {
                        translate([-(square/2),0,0]) {
                            cube([square, 50, height]);
                        }
                    }
                }
            }
            translate([0,-(40-5),-height]) {
                difference() {
                    linear_extrude (height = height) {
                        circle(r = 40);
                    }
                    linear_extrude (height = height) {
                       circle(r=30);
                    }
                }
            }
        }
    }

}

main();
