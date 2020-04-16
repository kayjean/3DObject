/*
Sliding Bolt
https://github.com/danmarshall/openscad-sliding-bolt
License: Apache 2.0
*/

module slidingbolt(travel, radius, height, lip, clearance, bolt_radius, flathead_radius, standoff, action) {
	$fn = 50;
	h2 = height / 2;
	h2l = h2 - lip;
	o = radius + h2 + 1;

	function flathead() = [
		[0, -1],
		[bolt_radius + flathead_radius, -1],
		[bolt_radius + flathead_radius, 0],
		[bolt_radius, flathead_radius],
		[bolt_radius, height + standoff + 1],
		[0, height + standoff + 1],
	];

	function profile(use_clearance, use_overlap, standoff) = [
		[0, -use_overlap], 
		[radius - use_clearance, -use_overlap], 
		[radius - use_clearance, lip + sin(22.5) * use_clearance],
		[radius + h2l - use_clearance * sqrt(2), h2],
		[radius - use_clearance, height - lip - sin(22.5) * use_clearance],
		[radius - use_clearance, height + use_overlap + standoff],
		[0, height + use_overlap + standoff]
	];

	module track() {
		module halftrack() {
			translate([0, travel, 0]){
				rotate([90, 0, 0]) {
					linear_extrude(height = travel) {
						polygon(points=profile(0, 1, 0));
					}
				}
			}
		}

		halftrack();
		mirror([1, 0, 0]) {
			halftrack();
		}
		rotate_extrude(height = height) {
			polygon(points=profile(0, 1, 0));
		}
		translate([0, travel, 0]) {
			rotate_extrude(height = height) {
				polygon(points=profile(0, 1, 0));
			}
		}
	}

	module sliderbolt() {
		difference() {
			rotate_extrude(height = height) {
				polygon(points=profile(clearance, 0, standoff));
			}
			rotate_extrude(height = height) {
				polygon(points=flathead());
			}
		}
	}

	if (action == "bolt") {
		sliderbolt();
	} else if (action == "track") {
		track();
	} else {
		difference() {
			translate([-o, -o, 0]) {
				cube([2 * o, 2 * o + travel, height]);
			}
			track();
		}

		sliderbolt();
	}
}

travel = 35;
radius = 6;
height = 6;
lip = 1;
bolt_radius = 2;
flathead_radius = 2.6;
clearance = 0.2;
standoff = 6;

slidingbolt(travel, radius, height, lip, clearance, bolt_radius, flathead_radius, standoff );

