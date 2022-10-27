import { app, BrowserWindow, ipcMain, dialog } from "electron"
import path from "path"
import { createProtocol } from "vue-cli-plugin-electron-builder/lib"
import Store from "electron-store"
Store.initRenderer()

const events = require("events")

let opaInv

const winConfig = {
  frame: false,
  show: false,
  resizable: false,
  // eslint-disable-next-line no-undef
  icon: path.join(__static, "./logo.png"),
  webPreferences: {
    nodeIntegration: true,
    contextIsolation: false,
    // eslint-disable-next-line no-undef
    preload: path.join(__static, './preload.js'),
  },
}

class Dashboard extends events {
  constructor(confInfo) {
    super()
    this.confInfo = confInfo
    this.conf = Object.assign({}, winConfig, confInfo)

    this.windowInstance = new BrowserWindow(this.conf)

    if (process.env.WEBPACK_DEV_SERVER_URL) {
      this.windowInstance.loadURL(
        `${process.env.WEBPACK_DEV_SERVER_URL}/#/dashboard`
      )
    } else {
      createProtocol("app")
      this.windowInstance.loadURL(`file://${__dirname}/index.html/#/dashboard`)
    }
    this.init()
  }

  init () {
    if (!app.isPackaged) {
      this.windowInstance.webContents.openDevTools()
    }
    this.windowInstance.once("ready-to-show", () => {
      // 窗口先透明
      this.windowInstance.setOpacity(0)
      // 解决闪白问题 增加 fade-in 效果
      setTimeout(() => {
        this.windowInstance.show()
        let opacity = 0.1
        opaInv = setInterval(() => {
          if (opacity >= 1) {
            // 结束 interval
            clearInterval(opaInv)
          } else {
            opacity = opacity + 0.1
            this.windowInstance.setOpacity(opacity)
          }
        }, 30)
      }, 500)
    })

    this.listenIpc()
  }

  listenIpc () {
    // 最小化
    ipcMain.on("main_minize", () => {
      this.windowInstance.minimize()
    })

    // 关闭
    ipcMain.on("main_close", () => {
      app.quit()
    })

    ipcMain.on("selectPath", (event) => {
      let pathDialog = dialog.showOpenDialogSync(this.windowInstance, {
        title: "选择保存路径",
        properties: ["openDirectory"], // 选择文件
      })
      if (pathDialog) {
        event.reply("newSavePath", pathDialog)
      }
    })
  }
}

export default Dashboard
