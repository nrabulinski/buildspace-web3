open Belt

@react.component
let make = (
	~s: bool => {..},
	~emote: string,
	~className: option<string>=?,
	~onClick,
	~children: React.element,
) => {
	let (hover, setHover) = React.useState(() => false)

	let style = Spring.useSpringObj(s(hover))

	<button
		onMouseEnter={_ => setHover(_ => true)}
		onMouseLeave={_ => setHover(_ => false)}
		onClick
		className={className->Option.getWithDefault("")}
	>
		<Spring.Animated.span style>{React.string(emote)}</Spring.Animated.span>
		{children}
	</button>
}
