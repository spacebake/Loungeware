/// @desc Update message lifetime.
lifeTimer += lifeCounter;
if (lifeTimer > 1) {
    instance_destroy();
    exit;
}