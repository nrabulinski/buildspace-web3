open ReactEvent.Synthetic
@module external s: {..} = "./Modal.module.css"

@react.component
let make = (~handleClose: () => unit, ~isOpen: bool, ~children: React.element) => {
	let (wasOpen, setWasOpen) = React.useState(() => false)

	React.useEffect3(() => {
		if !wasOpen && isOpen { 
			setWasOpen(_ => true)
		}
		None
	}, (isOpen, wasOpen, setWasOpen))

	<div className={`${s["bg"]} ${wasOpen ? isOpen ? s["shown"] : s["hidden"] : ""}`} onClick={_ => handleClose()}>
		<div className={s["modal"]} onClick={e => e->stopPropagation}>
			children
		</div>
	</div>
}
