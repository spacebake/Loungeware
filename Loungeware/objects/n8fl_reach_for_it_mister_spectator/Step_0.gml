offset_x += spd * dir;

var t = (TIME_MAX - TIME_REMAINING) / TIME_MAX;
var hop_t =  ((1 + sin((t+r)*hop_speed)) /2);
hop_offset = hop_t * -hop_force;