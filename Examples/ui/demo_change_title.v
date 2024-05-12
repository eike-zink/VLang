import ui

@[heap]
struct App {
mut:
	window &ui.Window = unsafe { nil }
	title  string
}

fn main() {
	mut app := &App{}
	app.window = ui.window(
		width: 450
		height: 120
		title: 'Name'
		children: [
			ui.column(
				spacing: 20
				margin: ui.Margin{30, 30, 30, 30}
				children: [
					ui.row(
						spacing: 10
						alignment: .center
						children: [
							ui.label(text: 'Title name: '),
							ui.textbox(
								max_len: 200
								width: 300
								placeholder: 'Please enter new title'
								is_focused: true
							),
						]
					),
					ui.button(text: 'Change title')
				]
			),
		]
	)
	ui.run(app.window)
}
