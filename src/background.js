"use strict"

import {
  app, screen, desktopCapturer, ipcMain, nativeImage, Tray, Menu,
} from "electron"
import Launch from "./wins/launch"
import Dashboard from "./wins/dashboard"
import SuspendBall from "./wins/ball"
import { BASE_WIN_WIDTH, BASE_WIN_HEIGHT, DESIGNE_LAUNCH_WIDTH, DESIGNE_LAUNCH_HEIGHT, DESIGNE_DASHBOARD_WIDTH, DESIGNE_DASHBOARD_HEIGHT, } from "./utils/constant"
import path from "path"

let ballWin
// eslint-disable-next-line no-unused-vars
let doashWin
let ballShow = false
let trayMenu
let iconTray

const noAppIcon = nativeImage.createFromPath(
  // eslint-disable-next-line no-undef
  path.join(__static, "./browser3.png")
)
const defaultAppIcon = nativeImage.createFromPath(
  // eslint-disable-next-line no-undef
  path.join(__static, "./screen2.png")
)

const getSize = () => {
  const { size, scaleFactor } = screen.getPrimaryDisplay()
  return {
    width: size.width * scaleFactor,
    height: size.height * scaleFactor,
  }
}

app.on("ready", async () => {
  const rect = screen.getPrimaryDisplay().bounds

  const launchW = Math.floor(
    (rect.width / BASE_WIN_WIDTH) * DESIGNE_LAUNCH_WIDTH
  )
  const launchH = Math.floor(
    (rect.height / BASE_WIN_HEIGHT) * DESIGNE_LAUNCH_HEIGHT
  )

  const dashboardW = DESIGNE_DASHBOARD_WIDTH
  const dashboardH = DESIGNE_DASHBOARD_HEIGHT

  const LaunchPage = new Launch({
    width: launchW,
    height: launchH,
  })

  LaunchPage.on("open_dashboard", () => {
    // 创建拖盘
    iconTray = new Tray(
      // eslint-disable-next-line no-undef
      path.join(__static, "./logo.png")
    )
    // 鼠标悬停托盘提示
    iconTray.setToolTip("伴舟录屏")
    // 配置右键菜单
    trayMenu = Menu.buildFromTemplate([
      {
        label: "开启悬浮窗口",
        type: "checkbox",
        click: function () {
          if (ballShow) {
            ballShow = false
          } else {
            ballShow = true
          }
          doashWin.windowInstance.webContents.send("ball-change")
        },
      },
      {
        label: "退出",
        click: function () {
          if (process.platform !== "darwin") {
            app.quit()
          }
        },
      },
    ])
    // 绑定右键菜单到托盘
    iconTray.setContextMenu(trayMenu)
    iconTray.on("click", function () {
      doashWin.windowInstance.focus()
    })

    doashWin = new Dashboard({
      with: dashboardW,
      height: dashboardH,
    })

    ballWin = new SuspendBall({
      width: 150,
      height: 35,
    })
  })
})

ipcMain.on("recive-deskTop", async (event) => {
  let sizeInfo = getSize()
  let source = await desktopCapturer.getSources({
    types: ["window", "screen"],
    fetchWindowIcons: true,
    thumbnailSize: sizeInfo,
  })
  source = source.map((item, index) => {
    let newItem = item
    if (index == 0) {
      newItem["appIcon"] = defaultAppIcon.toDataURL()
      newItem["name"] = "捕获屏幕"
    } else {
      if (item.appIcon) {
        newItem["appIcon"] = item.appIcon.toDataURL()
        if (newItem["appIcon"] == "data:image/png;base64,") {
          newItem["appIcon"] = noAppIcon.toDataURL()
        }
      } else {
        newItem["appIcon"] = noAppIcon.toDataURL()
      }
    }
    newItem["thumbnail"] = newItem.thumbnail.toDataURL()
    return newItem
  })
  event.reply("reply-source", JSON.stringify(source))
})

ipcMain.on("get-screen", (event) => {
  const rect = screen.getPrimaryDisplay().bounds
  const id = ballWin.windowInstance.webContents.id
  event.reply("reply-screen", { width: rect.width, height: rect.height, id })
})

ipcMain.on("ball-open", (event, data) => {
  if (data) {
    ballWin.windowInstance.show()
    trayMenu.items[0].checked = true
  } else {
    ballWin.windowInstance.hide()
    trayMenu.items[0].checked = false
  }
})
