const files = Variable("");
const monitors = Variable("");
const monitorsCount = Variable("");
const dir = Utils.exec(
	`bash -c "echo $HOME/dots-nix/home/desktop/wallpapers/"`,
);

function updateFiles() {
	files.value = Utils.exec(`ls -1 ${dir}`);
}

function updateMonitors() {
	monitors.value = Utils.exec(
		`bash -c "hyprctl monitors -j | jq -r '.[].name'"`,
	);
	monitorsCount.value = Utils.exec(
		`bash -c "hyprctl monitors -j | jq 'length'"`,
	);
}

function setWallpaper(path, monitor) {
	const fullDir = `${dir}${path}`;

	if (monitorsCount.value === "1") {
		Utils.exec(`swww img ${fullDir}`);
	} else {
		Utils.exec(`swww img --outputs ${monitor} ${fullDir}`);
	}
	App.resetCss();
	App.applyCss(`${App.configDir}/style.css`);
}

function closeWallpaperWindow() {
	App.closeWindow("wallpaper");
}

function closeMonitorWindow() {
	App.closeWindow("monitor");
	monitors.value = "";
}

function OpenWallpaper() {
	return Widget.Button({
		child: Widget.Icon({ icon: "starred" }),
		onClicked: () => {
			App.toggleWindow("wallpaper");
		},
	});
}

function Wallpaper() {
	const wallpaper = Widget.Window({
		name: "wallpaper",
		class_name: "wallpapers",
		anchor: ["bottom", "top", "left"],
		exclusivity: "exclusive",
		layer: "overlay",
		margins: [12, 1, 12, 12],
		visible: false,
		child: Widget.Scrollable({
			vscroll: "always",
			hscroll: "never",
			child: Widget.Box({
				class_name: "wallpaperContainer",
				vertical: true,
				children: files.bind().as((x) =>
					x
						.split("\n")
						.filter((x) => x !== "")
						.sort()
						.map((path) => ImagesList(path)),
				),
			}),
		}),
	});
	wallpaper.hook(
		App,
		() => {
			updateFiles();
		},
		"window-toggled",
	);
	return wallpaper;
}

function Monitor() {
	const monitor = Widget.Window({
		name: "monitor",
		class_name: "monitors",
		anchor: ["bottom", "top", "left"],
		exclusivity: "exclusive",
		layer: "overlay",
		margins: [12, 1, 12, 12],
		visible: false,
		child: Widget.Box({
			class_name: "monitorContainer",
			vertical: true,
			children: monitors.bind().as((x) =>
				x
					.split("\n")
					.filter((x) => x !== "")
					.sort()
					.map((monitor) => MonitorsList(monitor)),
			),
		}),
	});

	monitor.hook(
		App,
		() => {
			if (App.getWindow("wallpaper").visible) {
				closeMonitorWindow();
			}
		},
		"window-toggled",
	);
	return monitor;
}

function ImagesList(path) {
	return Widget.Button({
		class_name: "wallpaperButton",
		onPrimaryClick: () => {
			closeWallpaperWindow();
			updateMonitors();
			if (monitorsCount.value === "1") {
				setWallpaper(path, "", monitorsCount);
			} else {
				App.openWindow("monitor");
				setWallpaper.path = path;
			}
		},
		child: Widget.Icon({
			class_name: "wallpaperImage",
			size: 100,
			icon: `${dir}${path}`,
		}),
	});
}

function MonitorsList(monitor) {
	return Widget.Button({
		class_name: "monitorButton",
		onPrimaryClick: () => {
			closeMonitorWindow();
			setWallpaper(setWallpaper.path, monitor, monitorsCount);
		},
		child: Widget.Label({
			class_name: "monitorName",
			label: `${monitor}`,
		}),
	});
}
export { OpenWallpaper, Wallpaper, Monitor };
