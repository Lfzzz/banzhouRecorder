const { defineConfig } = require('@vue/cli-service')
const path = require('path')
module.exports = defineConfig({
  css: {
    loaderOptions: {
      scss: {
        additionalData: '@import "~@/assets/styles/colors.scss";'
      }
    }
  },
  configureWebpack: {
    resolve: {
      symlinks: false,
      alias: {
        vue: path.resolve('./node_modules/vue')
      },
      fallback: { path: require.resolve('path-browserify') }
    }
  },
  pluginOptions: {
    electronBuilder: {
      builderOptions: {
        artifactName: '伴舟录屏.exe',
        electronDownload: {
          mirror: "https://npm.taobao.org/mirrors/electron/",
        },
        appId: "com.dlz.bzlp",
        productName: "伴舟录屏",
        copyright: "Copyright © 2022",
        win: {
          icon: "./src/assets/images/logo.ico",
          target: [
            {
              target: "nsis",
              arch: ['x64'],
            },
          ],
        },
        nsis: {
          oneClick: false,
          allowElevation: true,
          allowToChangeInstallationDirectory: true,
          installerIcon: "./src/assets/images/logo.ico",
          uninstallerIcon: "./src/assets/images/uninstall.ico",
          installerHeaderIcon: "./src/assets/images/logo.ico",
          createDesktopShortcut: true,
          createStartMenuShortcut: false,
          shortcutName: "伴舟录屏",
        },
      },
    },
  },
})
