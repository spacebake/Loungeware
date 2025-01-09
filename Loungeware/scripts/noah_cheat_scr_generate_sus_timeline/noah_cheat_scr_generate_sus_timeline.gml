function generate_sus_timeline(){
	var _numLoops = num_sus_states * 2;
	var _timelinePos = bookend_time; // start time with cushion
	var _currentlySus = false;
	var _timeline = [];
	for (var _i = 0; _i < _numLoops; _i++)
	{
		if (_currentlySus)
		{
			_timelinePos += random_range(min_sus_duration, max_sus_duration);
		}
		else
		{
			_timelinePos += random_range(min_gap_between_sus_states, max_gap_between_sus_states);
		}
		_timeline[_i] = _timelinePos;
		_currentlySus = !_currentlySus;
	}
	return _timeline
}