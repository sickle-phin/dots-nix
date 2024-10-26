const b = Variable(false);
const files = Variable("");
const monitors = Variable("");
const dir = Utils.exec(`bash -c "echo $HOME/dots-nix/home/desktop/wallpapers/"`);
const statePath = Utils.exec(`bash -c "echo $LAST_WALLPAPER_PATH"`);

function updateFiles() {
	files.value = Utils.exec(`ls -1 ${dir}`);
}

function updateMonitors() {
	monitors.value = Utils.exec(
		`bash -c "hyprctl monitors -j | jq -r '.[].name'"`,
	);
}

function setWallpaper(path, monitor) {
	const fullDir = `${dir}${path}`;

	Utils.exec(`swww img --outputs ${monitor} ${fullDir}`);
	Utils.writeFile(fullDir, statePath);
	Utils.exec(`wpg -a ${fullDir} -n`);
	Utils.exec(`wpg -A ${path} -n`);
	Utils.exec(`wpg -s ${path} -n`);

	Utils.exec(`hyprctl reload`);
	App.resetCss();
	App.applyCss(`${App.configDir}/style.css`);
}

function closeWallpaperWindow() {
	App.closeWindow("wallpaper");
	files.value = "";
}

function closeMonitorWindow() {
	App.closeWindow("monitor");
	monitors.value = "";
}

function OpenWallpaper() {
	return Widget.Button({
		child: Widget.Icon({ icon: "starred" }),
		onClicked: () => {
			updateFiles();
			b.value = !b.value;
            closeMonitorWindow();
			App.toggleWindow("wallpaper");
		},
	});
}

function Wallpaper() {
	return Widget.Window({
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
}

function Monitor() {
	return Widget.Window({
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
}

function ImagesList(path) {
	return Widget.Button({
		class_name: "wallpaperButton",
		onPrimaryClick: () => {
			closeWallpaperWindow();
			updateMonitors();
			App.toggleWindow("monitor");
			setWallpaper.path = path;
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
			setWallpaper(setWallpaper.path, monitor);
		},
		child: Widget.Label({
			class_name: "monitorName",
			label: `${monitor}`,
		}),
	});
}
export { OpenWallpaper, Wallpaper, Monitor };
