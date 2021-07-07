image_speed = 0.28;
do_shoot = false;

words = 
[
	[
		[n8fl_penguin_blast_EProjectile.Primary,n8fl_penguin_blast_EProjectile.Primary],
		[n8fl_penguin_blast_EProjectile.Secondary,n8fl_penguin_blast_EProjectile.Secondary]
	],
	[
		[n8fl_penguin_blast_EProjectile.Primary,n8fl_penguin_blast_EProjectile.Secondary],
		[n8fl_penguin_blast_EProjectile.Secondary,n8fl_penguin_blast_EProjectile.Primary],
	]
];


phrase = ds_list_create();

var max_syl = 15;

while(ds_list_size(phrase) < max_syl){
	var group = words[ds_list_size(phrase) > max_syl / 2 ? 1 : 0];
	var index = irandom_range(0, array_length(group)-1);
	
	var word = group[index];
	if(ds_list_size(phrase) + array_length(word) > max_syl){
		continue;
	}
	
	for(var i = 0; i < array_length(word); i++){
		ds_list_add(phrase, word[i]);
	}
	
	ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
}