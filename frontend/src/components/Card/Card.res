@module external s: {..} = "./Card.module.css"

@react.component
let make = (~address: string, ~content: string, ~timestamp: float) => {
	<div className={s["card"]}>
		<p className={s["address"]}>{React.string(address)}</p>
		<p className={s["content"]}>{React.string(`👋 ${content}`)}</p>
		<p className={s["timestamp"]}>{React.string(Day.fromNow(timestamp))}</p>
	</div>
}
