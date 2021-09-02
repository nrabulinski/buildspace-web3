type conf = {
	mass: int,
	tension: int,
	friction: int
}

@module("react-spring")
external useSpringObj: {..} => {..} = "useSpring"

module Config = {
	@module("react-spring") @scope("config")
	external default: conf = "default"

	@module("react-spring") @scope("config")
	external gentle: conf = "gentle"

	@module("react-spring") @scope("config")
	external wobbly: conf = "wobbly"

	@module("react-spring") @scope("config")
	external stiff: conf = "stiff"

	@module("react-spring") @scope("config")
	external slow: conf = "slow"

	@module("react-spring") @scope("config")
	external molasses: conf = "molasses"

	let jello = {
		mass: 1,
		tension: 200,
		friction: 8
	}
}

module Animated = {
	@deriving(abstract)
	type spanProps<'s> = {
		@optional
		style: 's
		@optional
		children: React.element
	}

	@module("@react-spring/web") @scope("animated")
	external span: React.component<spanProps<{..}>> = "span"
}
