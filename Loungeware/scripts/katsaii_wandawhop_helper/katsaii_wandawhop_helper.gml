
function katsaii_wandawhop_interp_elastic(amount) {
    static curve = animcurve_get_channel(katsaii_wandawhop_bounce, 0);
    return animcurve_channel_evaluate(curve, amount);
}