if ( wait > 0 ) exit;
with ( other ) giz_beast_bullet_explode(other.image_blend);

if ( --life <= 0 ) instance_destroy();
if ( !is_face ) wait = 20;
else wait = 30;