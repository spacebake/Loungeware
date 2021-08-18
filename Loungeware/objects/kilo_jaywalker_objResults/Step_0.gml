if (delay <= 0)
{
	y = lerp(y,0,0.25);
}

delay --;

if (delay <= -120)
{
	microgame_end_early();
}

