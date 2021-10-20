/// @desc Initialise wanda.
image_speed = 0;
z = -CELL_SIZE;
zstart = z;
zprevious = z;
targetAngle = 45;
movementAngle = 0;
flip = false;
respawnTimer = -1;
jumpTimer = -1;
jumpZ = 0;
jumpHeight = 30;
allowJump = true;
jumpParity = false;
lastPlatform = noone;
heldStar = noone;
starsCollected = 0;
subimages = [
  {
      flip : true,
      idle : 6,
      walk : [6, 8, 6, 7],
      jump : [8, 7],
  },
  {
      flip : false,
      idle : 3,
      walk : [3, 4, 3, 5],
      jump : [4, 5],
  },
  {
      flip : false,
      idle : 6,
      walk : [6, 7, 6, 8],
      jump : [7, 8],
  },
  {
      flip : false,
      idle : 2,
      walk : [2, 1, 2, 0],
      jump : [1, 0],
  },
];