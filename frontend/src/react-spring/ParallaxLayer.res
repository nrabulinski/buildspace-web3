open React
open Belt

type stickyc = {
	"start": float,
	"end": float
}

type props<'s> = {
	"children": option<element>,
	"offset": option<float>,
	"style": option<'s>,
	"className": option<string>,
	"speed": option<float>,
	"factor": option<float>,
	"sticky": option<stickyc>,
}

@obj
external makeProps: (
	~offset: float=?,
	~children: element=?,
	~style: 's=?,
	~className: string=?,
	~speed: float=?,
	~factor: float=?,
	~sticky: stickyc=?,
	unit,
) => props<{..}> = ""

let sticky = (~start=?, ~end=?, ()) => {
	"start": start->Option.getWithDefault(0.),
	"end": end->Option.getWithDefault(1.),
}

@module("@react-spring/parallax")
external make: component<props<{..}>> = "ParallaxLayer"
