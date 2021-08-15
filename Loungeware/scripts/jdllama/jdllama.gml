// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function jdllama_outlinedText(x, y, outline, color, str){
	var xx, yy;
	xx = x;
	yy = y;
	
	draw_set_color(outline);
	draw_text(xx+1, yy+1, str);  
	draw_text(xx-1, yy-1, str);  
	draw_text(xx,   yy+1, str);  
	draw_text(xx+1,   yy, str);  
	draw_text(xx,   yy-1, str);  
	draw_text(xx-1,   yy, str);  
	draw_text(xx-1, yy+1, str);  
	draw_text(xx+1, yy-1, str);  
	
	draw_set_color(color);
	draw_text(xx, yy, str);
}