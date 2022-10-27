const fs = window.require('fs')
const path = window.require('path')
let SAVE_PATH = 'd:/videos'

const mkdirDirectory = (pathUrl) => {
  return new Promise(resolve => {
    if (!fs.existsSync(pathUrl)) {
      const res = fs.mkdirSync(pathUrl, { recursive: true })
      if (res) {
        resolve(true)
      }
    } else {
      resolve(true)
    }
  })
}

const add0 = (m) => { return m < 10 ? '0' + m : m }

const format = (timeCode, type = 'default') => {

  //shijianchuo是整数，否则要parseInt转换

  var time = new Date(timeCode)

  var y = time.getFullYear()

  var m = time.getMonth() + 1

  var d = time.getDate()

  var h = time.getHours()

  var mm = time.getMinutes()

  var s = time.getSeconds()

  if (type == 'default') {
    return y + '-' + add0(m) + '-' + add0(d) + ' ' + add0(h) + ':' + add0(mm) + ':' + add0(s)
  } else {
    return `${y}${m}${d}${h}${mm}${s}`
  }

}

export const saveVideo = (blob, info, time, savePath, store) => {
  return new Promise((resolve, reject) => {
    SAVE_PATH = savePath
    const times = new Date().getTime()
    mkdirDirectory(SAVE_PATH).then(() => {
      const videoPath = path.join(SAVE_PATH, `${info.name}${format(times, 'str')}.mp4`)
      let videoInfo = {
        name: `${info.name}${format(times, 'str')}.mp4`,
        time: time,
        icon: info.appIcon,
        create: format(times),
        path: videoPath,
        dirPath: SAVE_PATH,
      }
      const reader = new FileReader()
      reader.readAsArrayBuffer(blob)
      reader.onload = () => {
        const buffer = Buffer.from(reader.result)
        fs.writeFile(videoPath, buffer, {}, (err) => {
          if (err) return
        })
      }
      reader.onloadend = () => {
        if (store.get('videoList')) {
          let oldList = JSON.parse(store.get('videoList'))
          console.log(videoInfo)
          oldList.unshift(videoInfo)
          console.log(oldList)
          store.set('videoList', JSON.stringify(oldList))
        } else {
          store.set('videoList', JSON.stringify([videoInfo]))
        }
        resolve(true)
      }
      reader.onerror = (err) => {
        reject(err)
      }
    })
  })
}

export const directoryFile = (store) => {
  if (store.get('videoList')) {
    let nowList = JSON.parse(store.get('videoList'))
    let newList = nowList.filter(item => {
      return fs.existsSync(item.path)
    })
    store.set('videoList', JSON.stringify(newList))
    return newList
  } else {
    return []
  }
}

export const deleteVideo = (videoInfo, store) => {
  return new Promise((resolve) => {
    if (fs.existsSync(videoInfo.path)) {
      fs.unlink(videoInfo.path, (err) => {
        if (err) {
          alert("An error ocurred updating the file" + err.message)
          resolve('err1')
        }
        let nowList = JSON.parse(store.get('videoList'))
        let index = nowList.findIndex(item => item.name == videoInfo.name)
        console.log(index)
        nowList.splice(index, 1)
        console.log(nowList)
        store.set('videoList', JSON.stringify(nowList))
        resolve(true)
      })
    } else {
      alert("This file doesn't exist, cannot delete")
      resolve('err2')
    }
  })
}

export const formatSeconds = (time) => {
  let h = parseInt(time / 60 / 60 % 24)
  h = h < 10 ? '0' + h : h
  let m = parseInt(time / 60 % 60)
  m = m < 10 ? '0' + m : m
  let s = parseInt(time % 60)
  s = s < 10 ? '0' + s : s
  return `${h}:${m}:${s}`
}