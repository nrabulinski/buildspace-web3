open React

type props<'s> = {
	"children": option<element>,
	"style": option<'s>,
	"pages": int,
	"className": option<string>,
}

@obj
external makeProps: (
	~children: element=?,
	~style: 's=?,
	~pages: int,
	~className: string=?,
	unit,
) => props<{..}> = ""

@module("@react-spring/parallax")
external make: component<props<{..}>> = "Parallax"
