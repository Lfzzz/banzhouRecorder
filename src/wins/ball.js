import { app, BrowserWindow, screen } from "electron"
import { createProtocol } from "vue-cli-plugin-electron-builder/lib"

const events = require("events")
app.commandLine.appendSwitch('wm-window-animations-disabled')

const winConfig = {
  frame: false,
  show: false,
  transparent: true,
  alwaysOnTop: true,
  focusable: false,
  resizable: false,
  webPreferences: {
    nodeIntegration: true,
    contextIsolation: false,
  },
}

class SuspendBall extends events {
  constructor(confInfo) {
    super()
    this.confInfo = confInfo
    this.conf = Object.assign({}, winConfig, confInfo)
    const rect = screen.getPrimaryDisplay().bounds
    let left = rect.width - 180
    let top = rect.height - 115

    console.log(left, top)

    this.windowInstance = new BrowserWindow(this.conf)

    this.windowInstance.setPosition(left, top)

    if (process.env.WEBPACK_DEV_SERVER_URL) {
      this.windowInstance.loadURL(
        `${process.env.WEBPACK_DEV_SERVER_URL}/#/suspend`
      )
    } else {
      createProtocol("app")
      this.windowInstance.loadURL("app://./index.html/#/suspend")
    }

    if (!app.isPackaged) {
      this.windowInstance.webContents.openDevTools()
    }
  }
}

export default SuspendBall
