import { BrowserWindow } from "electron";
import { createProtocol } from "vue-cli-plugin-electron-builder/lib";

const events = require("events");

let opaInv;

const winConfig = {
  show: false,
  frame: false,
  focusable: true,
  resizable: false,
  transparent: true,
  center: true,
  backgroundColor: "#00000000",
  webPreferences: {
    nodeIntegration: true,
    contextIsolation: false,
  },
};

class Launch extends events {
  constructor(confInfo) {
    super();
    this.confInfo = confInfo;
    this.conf = Object.assign({}, winConfig, confInfo);

    this.windowInstance = new BrowserWindow(this.conf);

    if (process.env.WEBPACK_DEV_SERVER_URL) {
      this.windowInstance.loadURL(
        `${process.env.WEBPACK_DEV_SERVER_URL}/#/launch`
      );
    } else {
      createProtocol("app");
      this.windowInstance.loadURL("app://./index.html/#/launch");
    }

    this.init();
  }

  init() {
    this.windowInstance.once("ready-to-show", () => {
      // 启动页不显示图标在任务栏
      this.windowInstance.setSkipTaskbar(true);
      // 窗口先透明
      this.windowInstance.setOpacity(0);

      // 解决闪白问题 增加 fade-in 效果
      setTimeout(() => {
        this.windowInstance.show();
        let opacity = 0.1;
        opaInv = setInterval(() => {
          if (opacity >= 1) {
            // 结束 interval
            clearInterval(opaInv);
            setTimeout(() => {
              this.emit("open_dashboard");
            }, 3000);
            setTimeout(() => {
              this.close();
            }, 3300);
          } else {
            opacity = opacity + 0.1;
            this.windowInstance.setOpacity(opacity);
          }
        }, 30);
      }, 500);
    });
  }

  close() {
    if (this.windowInstance && this.windowInstance.isVisible) {
      let opacity = 1;
      opaInv = setInterval(() => {
        if (opacity <= 0) {
          // 结束 interval
          clearInterval(opaInv);
          this.windowInstance.close();
          this.windowInstance = null;
        } else {
          opacity = opacity - 0.1;
          this.windowInstance.setOpacity(opacity);
        }
      }, 15);
    }
  }
}

export default Launch;
