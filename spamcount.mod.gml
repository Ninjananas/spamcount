#define init
global.sprCrownTopScore = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAAAkAAAAGCAYAAAARx7TFAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAtSURBVBhXYwCC/zAMBCACjJHFwZz/N1AE4BhJHMKBCSDTWBVhw6Qpwo8Z/gMAdLViaJoK6qkAAAAASUVORK5CYIIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==",
1, 9, 3);
global.spamcount=[];
global.np=0;

#define game_start
global.np=0;
for(var i = 0; i < maxp; i += 1)
{
	if(player_get_alias(i) != "")
	{
		global.np += 1;
	}
}

for (var i=0; i<global.np; i+=1)
{
	global.spamcount[i]=0;
}

#define step
with(projectile) if "counted" not in self
{
	for (var i=0; i<global.np; i+=1)
	{
		if player_find(i) == creator
		{
			global.spamcount[i] += 1;
		}
	}
	counted=1;
}

#define draw_gui
if (GameCont.area != 0)
{
	x_offset=120;
	y_offset=240;
	draw_set_font(fntSmall);
	draw_set_halign(1);
	winner=-1;
	highest_spam=-1;
	for (var i=0; i<global.np; i+=1)
	{
		if (global.spamcount[i] > highest_spam)
		{
			highest_spam=global.spamcount[i];
			winner=i;
		}
	}
	var dist = 8;
	for(var i=0; i<global.np; i+=1)
	{
		var text = player_get_alias(i) + ": " + string(global.spamcount[i]);
		draw_text_nt(x_offset, y_offset-dist+1, text);

		if(winner == i)
		{
			draw_sprite(global.sprCrownTopScore, 0, x_offset-string_length(text)*2-(sprite_get_width(global.sprCrownTopScore)/2), y_offset-dist+4);
		}
		dist += 6;
	}
	draw_text_nt(x_offset, y_offset-dist+1, "SPAM");
}
