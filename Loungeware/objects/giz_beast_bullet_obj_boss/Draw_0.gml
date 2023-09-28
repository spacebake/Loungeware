draw_text(5, 5, string(phase));

// Check surfaces
verify_surfaces();

// Scaling
var xscl = 1 + ( dcos(current_time/5) * .2 );
var yscl = 2 - xscl;
var xx = x - width * .5 * xscl;
var yy = y - height *.5 * yscl;

// Draw brain
draw_sprite_ext(giz_beast_bullet_spr_larold_face, 3, x, y, 1, 1, angle, c_white, 1);

// Draw surfaces
if ( phase >= 3 ) exit;
if ( phase < 2 ) draw_surface_ext(surface[phase+1], xx, yy, xscl, yscl, 0, c_white, 1);
draw_surface_ext(surface[phase], xx, yy, xscl, yscl, 0, c_white, 1);
