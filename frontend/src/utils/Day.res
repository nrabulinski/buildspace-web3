@module external _dayjs: {..} = "dayjs"

@module external _relativeTimePlugin: {..} = "dayjs/plugin/relativeTime"
_dayjs["extend"](. _relativeTimePlugin)

let fromNow: float => string = date => _dayjs["unix"](. date)["fromNow"](.)
