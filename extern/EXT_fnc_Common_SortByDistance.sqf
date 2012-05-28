Private["_count","_count1","_current","_nearest","_nearestDistance","_object","_objects","_sorted","_total"];

_object = _this Select 0;
_objects = +(_this Select 1);

_sorted = [];

_total = Count _objects;
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	_nearest = ObjNull;
	_nearestDistance = 100000;

	for [{_count1 = Count _objects - 1},{_count1 >= 0},{_count1 = _count1 - 1}] do {
		_current = _objects Select _count1;
		_distance = _current Distance _object;

		if (_distance < _nearestDistance) then {_nearest = _current;_nearestDistance = _distance};
	};

	_sorted = _sorted + [_nearest];
	_objects = _objects - [_nearest];
};

_sorted