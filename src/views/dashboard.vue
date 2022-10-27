<template>
  <Layer>
    <!-- 结束时纸屑动画 -->
    <template #finishSlot>
      <div v-show="showFinish"
        :class="[showFinishAnimate?'animate__animated animate__fadeIn':'animate__animated animate__fadeOut']"
        class="absolute left-4 bottom-4 w-56 h-56" style="z-index: 999;">
        <Vue3Lottie ref="finishLottie" :autoPlay="false" :speed="1.5" :animationData="finish" :loop="false"
          height="100%" width="100%" />
      </div>
    </template>

    <!-- 右上操作模块 -->
    <template #rightMainWindow>
      <div class="w-full h-full overflow-hidden select-none flex flex-col" v-loading="loading">
        <div v-if="currentSouce" class="flex items-center justify-center w-full h-2/3 overflow-hidden">
          <img :src="currentSouce.thumbnail" class="w-full h-full" style="object-fit: cover;vertical-align: middle;" />
        </div>
        <div v-if="currentSouce" class="flex justify-between items-center my-3 pl-3 pr-4">
          <div class="flex items-center flex-1 w-0" style="height: 34px;">
            <img :src="currentSouce.appIcon" style="width: 28px;height: 28px;">
            <div class="ml-2 flex-1 truncate" style="font-size: 17px;height: 28px;line-height: 28px;">
              {{currentSouce.name}}
            </div>
          </div>
          <div class="flex items-center ml-3">
            <img src="@/assets/images/clock.png" style="width: 19px;height: 19px;">
            <div class="ml-1" style="font-size: 19px">{{videoTime}}</div>
          </div>
        </div>
        <div v-if="currentSouce" class="flex justify-between px-4 flex-1">
          <div v-show="!recording" @click="changeMic"
            class="myBtn_left flex justify-center items-center box-border overflow-hidden mr-auto">
            <div class="relative" style="width: 20px;height: 20px;">
              <div class="absolute" style="left: 50%;top: 50%;transform: translate(-50%,-50%)">
                <Vue3Lottie ref="micAnimate" :autoPlay="false" :animationData="mic" :loop="false" height="48px"
                  width="48px" />
              </div>
            </div>
            <BtnLoadingText :width="20" :height="20" :title="configVoiceType=='system'?'录音关':'录音开'" textColor="#FFFFFF">
            </BtnLoadingText>
          </div>
          <div v-show="!recording" @click="changeSource"
            class="myBtn_default flex justify-center items-center box-border overflow-hidden">
            <BtnLoadingText v-model="showBtnLoading" :width="20" :height="20" :icon="icon" title="切换源"
              textColor="#FFFFFF"></BtnLoadingText>
          </div>
          <div @click="sourceStart"
            class="myBtn_red flex justify-center items-center box-border overflow-hidden ml-auto">
            <BtnLoadingText v-model="showBtnLoading2" :width="22" :height="22" :icon="icon2"
              :title="recording?'结 束':'录 制'" textColor="#FFFFFF"></BtnLoadingText>
          </div>
        </div>
      </div>
    </template>

    <!-- 录屏记录列表 -->
    <template #recordList>
      <div v-loading="listLoading" class="flex flex-1 overflow-hidden px-1 relative"
        style="height: 0;padding-top: 45px;padding-bottom: 15px;">
        <div v-if="recordListData.length==0 && !listLoading" class="absolute"
          style="left: 50%;top: 50%;transform: translate(-50%,-50%);width: 230px;height: 230px;">
          <Vue3Lottie :autoPlay="true" :animationData="nodata" :loop="true" height="100%" width="100%" />
          <div
            style="text-align: center;position: relative;top: -20px;color: #77636b;font-size: 18px;left: 3px;user-select: none">
            暂无记录
          </div>
        </div>
        <c-scrollbar v-else width="100%" height="100%" trigger="hover" :vBarStyle="{'background-color': '#e3e6ee'}"
          :vThumbStyle="{'background-color': 'rgba(165, 173, 246,.4)'}">
          <div @mouseenter="enterItemIndex = index" @mousemove="enterItemIndex = index"
            @mouseleave="enterItemIndex = -1" v-for="(item,index) in recordListData" :key="item"
            :style="{marginTop:index==0?'0':'20px'}"
            class="px-3 py-2 rounded-tr-2xl rounded-bl-2xl select-none relative mx-3 overflow-hidden"
            style="background: #EFF1F5;">
            <div class="flex items-center py-2">
              <img class="w-7 h-7" :src="item.icon">
              <div class="truncate ml-2" style="font-size: 17px">
                {{item.name}}</div>
            </div>
            <div class="flex items-center mt-1">
              <div class="tag flex items-center" style="font-size: 16px">
                <img class="w-5 h-5" src="@/assets/images/clockIcon.png">
                <span style="color: #878787;" class="ml-1">{{item.time}}</span>
              </div>
              <div class="tag flex items-center ml-3" style="font-size: 16px">
                <img class="w-5 h-5" src="@/assets/images/createTime.png">
                <span style="color: #878787;" class="ml-1">{{item.create.slice(0,16)}}</span>
              </div>
            </div>
            <div
              :style="{left:enterItemIndex==index && index%2 == 0?'0':'',right:enterItemIndex==index && index%2 != 0?'0':'',opacity:enterItemIndex==index?1:0}"
              class="absolute w-full h-full top-0 flex items-center justify-center"
              :class="[index%2==0?'-left-full':'-right-full']"
              style="backdrop-filter: blur(5px);transition:ease-in-out all .2s;transition-delay: 0.1s;">
              <div @click="openVideo(item.path)" class="w-12 h-12 rounded-full mx-3 flex items-center justify-center"
                style="background: #FCA77E;box-shadow: 0 0 4px #FCA77E">
                <img class="w-7 h-7 relative" src="@/assets/images/play3.png" style="left: 2px">
              </div>
              <div @click="showShellPath(item.path)"
                class="w-12 h-12 rounded-full mx-3 flex items-center justify-center"
                style="background: #FCCF72;box-shadow: 0 0 4px #FCCF72">
                <img class="w-7 h-7 relative" src="@/assets/images/files.png" style="left: 2px">
              </div>
              <div @click="deleteThisVideo(item,index)"
                class="w-12 h-12 rounded-full mx-3 flex items-center justify-center"
                style="background: #FC7E7E;box-shadow: 0 0 4px #FC7E7E">
                <img class="w-6 h-6 relative" src="@/assets/images/delete.png">
              </div>
            </div>
          </div>
        </c-scrollbar>
      </div>
    </template>

    <template #rightSettingWindow>
      <div v-loading="loading" class="p-3 w-full h-full select-none">
        <div @click="changeSavePath" class="relative rounded-md mt-4 px-3 flex items-center"
          style="border: 2px solid #A6A6A6;height: 45px;">
          <div class="absolute px-1" style="top: -9px;color: #7D7D7D;font-size: 14px;background: #e3e6ee;">保存路径</div>
          <div class="flex justify-between items-center w-full">
            <div class="truncate" style="color: #7D7D7D;font-size: 16px;flex: 1;">{{savePath}}</div>
            <div class="dirBtn flex items-center flex-shrink-0 ml-2">
              <img class="w-4 h-4 mr-1" src="@/assets/images/wjj.png">
              <span>更改</span>
            </div>
          </div>
        </div>
        <div class="relative rounded-md mt-4 px-3 flex items-center" style="border: 2px solid #A6A6A6;height: 45px;">
          <div @click="ballSwitch" class="flex justify-between items-center w-full">
            <div class="truncate" style="color: #7D7D7D;font-size: 16px;flex: 1;">开启悬浮窗口</div>
            <div style="width: 130px;height: 26px;overflow: hidden;" class="flex justify-end items-center">
              <Vue3Lottie style="position: relative;right: -32px;" ref="switchLottie" :autoPlay="false" :speed="3"
                :animationData="switchLottieJson" :loop="false" width="100%" height="125px" />
            </div>
          </div>
        </div>
      </div>
    </template>

    <!-- 选择录制源的弹窗 -->
    <template #dialogSlot>
      <Dialog ref="DialogRef" v-model="showSouceDialog" :icon="icon" :title="'切换视频源'">
        <div class="grid grid-cols-5 gap-2 pt-4 pb-2">
          <div @click="pickSource(item,index)" v-for="(item,index) in sourceData" :key="item.id"
            class="flex flex-col p-3 pt-4 items-center w-full h-full relative rounded-md"
            :class="{'inShadow':pickCurrentSouceIndex == index,'sourceItemBox':pickCurrentSouceIndex != index}"
            style="transition: ease-out .3s;border: 3px solid #FFFFFF;box-sizing: border-box;">
            <div class="flex items-center justify-star mb-3" style="width:50px;height: 50px">
              <img class="w-full" :src="item.appIcon">
            </div>
            <div class="text-sm w-full truncate text-center" style="color: #7D7D7D;">
              {{item.name}}</div>
            <div class="absolute rounded-full -top-1.5 -left-1.5 flex justify-center items-center"
              style="width: 20px;height: 20px;">
              <Vue3Lottie :ref="el => { if(el) lottieItems[index] = el}" v-show="pickCurrentSouceIndex==index"
                :autoPlay="true" :speed="3" class="flex-shrink-0" :animationData="checkLottieJson" :loop="false"
                height="65px" width="65px" />
            </div>
          </div>
        </div>
        <template #footer>
          <div v-if="pickCurrentSouce"
            class="w-auto h-full flex justify-center items-center mt-1 mx-6 py-2 px-6 rounded-md"
            style="border: 2px dashed #A5ADF6">
            <div class="mr-3 flex-1 flex items-center overflow-hidden justify-end" style="height: 38px;">
              <img :src="pickCurrentSouce.appIcon" style="width: 38px;height: 38px;">
              <div class="ml-3 truncate flex-1" style="height: 38px;line-height: 38px;font-size: 18px">
                {{pickCurrentSouce.name}}
              </div>
            </div>
            <div @click="confirmSource" class="myBtn text-white flex justify-center items-center box-border">
              确定
            </div>
          </div>
        </template>
      </Dialog>
    </template>
  </Layer>
</template>
<script>
import { defineComponent, onMounted, reactive, ref, toRefs } from "vue"
import Layer from "@/components/layer.vue"
import Dialog from '@/components/dialog.vue'
import BtnLoadingText from '@/components/btnLoadingText.vue'
import checkLottieJson from '@/assets/lotties/check6.json'
import nodata from '@/assets/lotties/noData.json'
import { saveVideo, directoryFile, formatSeconds, deleteVideo } from '../utils/helper'
import path from "path"
const { ipcRenderer, shell } = window.require('electron')
import mic from '@/assets/lotties/mic.json'
import finish from '@/assets/lotties/finish3.json'
import switchLottieJson from '@/assets/lotties/switch.json'
import fixWebmDuration from 'webm-duration-fix'
const Store = window.Store
const store = new Store()

const getSource = () => {
  return new Promise(resolve => {
    ipcRenderer.send('recive-deskTop')
    ipcRenderer.on('reply-source', (event, data) => {
      resolve(data)
    })
  })
}
export default defineComponent({
  name: "Dashboard", // 组件名称
  components: {
    Layer,
    Dialog,
    BtnLoadingText,
  },
  setup () {
    let icon = require('../assets/images/changeIcon.png')
    let icon2 = require('../assets/images/recordIcon.png')
    const micAnimate = ref(null)

    const finishLottie = ref(null)

    const DialogRef = ref(null)

    const lottieItems = ref([])

    const recorder = ref(null)

    const switchLottie = ref(null)

    const state = reactive({
      sourceData: [],
      showSouceDialog: false,
      currentSouceIndex: 0,
      currentSouce: null,
      pickCurrentSouceIndex: 0,
      pickCurrentSouce: null,
      itemRefs: [],
      loading: true,
      listLoading: true,
      showBtnLoading: false,
      showBtnLoading2: false,
      enterItemIndex: -1,
      recording: false,
      recordListData: [],
      videoTime: '00:00:00',
      videoTimeSeconds: 0,
      videoTimeInv: null,
      savePath: '',
      videoRecorderWidth: 1920,
      videoRecorderHeight: 1080,
      configVoiceType: 'system',
      showFinish: false,
      showFinishAnimate: false,
      suspendId: null,
      ballShow: false,
    })

    const getPreview = async (type) => {
      const source = await getSource()
      state.sourceData = JSON.parse(source)
      // 获取到的 source 信息
      console.log(state.sourceData)
      state.currentSouce = state.sourceData[state.currentSouceIndex]
      if (type == 'default') {
        state.pickCurrentSouce = state.sourceData[state.pickCurrentSouceIndex]
      }
      state.listLoading = false
      state.loading = false
      setTimeout(() => {
        state.showBtnLoading = false
      }, 300)
      if (type == 'click') {
        state.showSouceDialog = true
      }
    }

    onMounted(() => {
      state.recordListData = directoryFile(store)
      let savePath = store.get('savePath')
      if (savePath) {
        state.savePath = savePath
      } else {
        store.set('savePath', 'D:\\videos')
        state.savePath = 'D:\\videos'
      }
      setTimeout(() => {
        getPreview('default')
      }, 1000)

      ipcRenderer.send('get-screen')
      ipcRenderer.on('reply-screen', (event, data) => {
        state.videoRecorderWidth = data.width
        state.videoRecorderHeight = data.height
        state.suspendId = data.id
      })
      ipcRenderer.on('ball-change', () => {
        ballSwitch()
      })
    })

    const pickSource = (item, index) => {
      if (state.pickCurrentSouceIndex == index) return
      lottieItems.value[state.currentSouceIndex].stop()
      state.pickCurrentSouceIndex = index
      state.pickCurrentSouce = item
      lottieItems.value[state.pickCurrentSouceIndex].stop()
      lottieItems.value[state.pickCurrentSouceIndex].play()
    }

    const changeSource = () => {
      if (state.showBtnLoading) return
      state.showBtnLoading = true
      getPreview('click')
    }

    const confirmSource = () => {
      state.currentSouce = state.pickCurrentSouce
      state.currentSouceIndex = state.pickCurrentSouceIndex
      DialogRef.value.closeDialog()
    }
    // 开始录屏
    const sourceStart = async () => {
      if (state.recording) {
        recorder.value && recorder.value.stop()
        return
      }
      state.showBtnLoading2 = true
      state.recording = true
      navigator.mediaDevices.getUserMedia({
        audio: false,
        video: {
          mandatory: {
            chromeMediaSource: 'desktop',
            chromeMediaSourceId: state.currentSouce.id,
            // 这里可以设置录制分辨率
            minWidth: state.videoRecorderWidth,
            minHeight: state.videoRecorderHeight,
            maxWidth: 8000,
            maxHeight: 8000,
          }
        }
      }).then(async videoStream => {
        if (videoStream) {
          let audio = await getDisplayMediaSource()
          if (audio) {
            // 将获取的音频流数据添加到视频流
            videoStream.addTrack(audio.getAudioTracks()[0])
            recordStart(videoStream)
          } else {
            recordStart(videoStream)
          }
          state.showBtnLoading2 = false
        }
      }).catch(err => console.error('startRecord error', err))
    }

    const getDisplayMediaSource = async () => {
      let audioStream = null
      // 音频分为系统和麦克风
      let constraints = null
      if (state.configVoiceType === 'microphone') {
        constraints = { audio: true, video: false }
      }
      if (state.configVoiceType === 'system') {
        constraints = {
          audio: {
            mandatory: { chromeMediaSource: 'desktop' }
          },
          video: {
            mandatory: { chromeMediaSource: 'desktop' }
          }
        }
      }
      await navigator.mediaDevices.getUserMedia(constraints)
        .then(function (audio) {
          audioStream = audio
        })
        .catch(function (err) {
          console.log('获取麦克风失败：' + err)
          audioStream = null
        })
      return audioStream
    }

    // 计时方法
    const videoTimeStart = () => {
      state.videoTimeInv = setInterval(() => {
        state.videoTimeSeconds++
        state.videoTime = formatSeconds(state.videoTimeSeconds)
        ipcRenderer.sendTo(state.suspendId, 'timeChange', state.videoTime)
      }, 1000)
    }

    const recordStart = async (stream) => {
      let blobSlice = []

      // 注意mimeType的值 以及 fixWebmDuration 才能解决 webm进度条无法拖动问题
      // eslint-disable-next-line no-useless-escape
      const mimeType = 'video/webm\;codecs=vp9'
      recorder.value = new MediaRecorder(stream, {
        mimeType: mimeType,
        audioBitsPerSecond: 128000,
        videoBitsPerSecond: '10000000'
      })
      if (recorder.value) {
        videoTimeStart()
        recorder.value.start(1000)
        recorder.value.ondataavailable = (event) => {
          var data = event.data
          if (data && data.size > 0) {
            blobSlice.push(data)
          }
        }
        recorder.value.onstop = async () => {
          const blob = new Blob([...blobSlice], { type: mimeType })
          //结束录制时下载视频
          const fixedBlob = await fixWebmDuration(blob)
          clearInterval(state.videoTimeInv)
          const videoTime = state.videoTime
          state.videoTime = '00:00:00'
          ipcRenderer.sendTo(state.suspendId, 'timeChange', state.videoTime)
          state.videoTimeSeconds = 0
          state.recording = false
          state.listLoading = true
          finishAnimateShow()
          setTimeout(() => {
            saveVideo(fixedBlob, state.currentSouce, videoTime, state.savePath, store).then(() => {
              state.recordListData = directoryFile(store)
              state.listLoading = false
            })
          }, 1000)
        }

        recorder.value.onerror = (err) => {
          console.log(err)
        }
      }
    }

    const changeSavePath = () => {
      ipcRenderer.send('selectPath')
      ipcRenderer.on('newSavePath', (event, data) => {
        state.savePath = data[0]
        console.log(data)
        store.set('savePath', data[0])
      })
    }

    // 打开系统资源管理器
    const showShellPath = (pathName) => {
      shell.showItemInFolder(path.join(pathName))
    }


    // 打开系统资源管理器
    const openVideo = (pathName) => {
      shell.openPath(pathName)
    }

    // 删除文件
    const deleteThisVideo = (item, index) => {
      state.listLoading = true
      deleteVideo(item, store).then(res => {
        if (res === true) {
          setTimeout(() => {
            state.recordListData.splice(index, 1)
          }, 800)
          setTimeout(() => {
            state.listLoading = false
          }, 1000)
          // 删除成功
        } else if (res === 'err1') {
          setTimeout(() => {
            state.listLoading = false
          }, 1000)
          // 删除出错
        } else {
          setTimeout(() => {
            state.listLoading = false
          }, 1000)
          // 文件不存在
        }
      })
    }

    // 麦克风开关
    const changeMic = () => {
      state.configVoiceType = state.configVoiceType == 'system' ? 'microphone' : 'system'
      if (state.configVoiceType == 'system') {
        micAnimate.value.playSegments([45, 90], true)
      } else {
        micAnimate.value.playSegments([0, 45], true)
      }
    }

    // 录制完成纸屑动画
    const finishAnimateShow = () => {
      state.showFinish = true
      state.showFinishAnimate = true
      setTimeout(() => {
        finishLottie.value.playSegments([0, 53], true)
        setTimeout(() => {
          state.showFinishAnimate = false
          setTimeout(() => {
            finishLottie.value.stop()
            state.showFinish = false
          }, 1000)
        }, 1000)
      }, 500)
    }

    // 悬浮窗显隐
    const ballSwitch = () => {
      if (state.ballShow) {
        state.ballShow = false
        switchLottie.value.playSegments([80, 0], true)
        ipcRenderer.send('ball-open', false)
      } else {
        state.ballShow = true
        switchLottie.value.playSegments([0, 80], true)
        ipcRenderer.send('ball-open', true)
      }
    }

    return {
      DialogRef,
      micAnimate,
      finishLottie,
      switchLottie,
      icon,
      icon2,
      nodata,
      mic,
      finish,
      switchLottieJson,
      checkLottieJson,
      lottieItems,
      ...toRefs(state),
      pickSource,
      changeSource,
      confirmSource,
      sourceStart,
      showShellPath,
      changeSavePath,
      openVideo,
      changeMic,
      deleteThisVideo,
      ballSwitch
    }
  },
})
</script>
<style scoped lang="scss">
.sourceItemBox:hover {
  transform: translateY(2px);
  box-shadow: inset 0 0px 8px rgba(120, 120, 120, .2);
}

.inShadow {
  border: 3px solid rgb(88, 123, 228) !important;
  transform: translateY(-3px);
  box-shadow: 0 2px 6px 0 rgba(88, 123, 228, 0.2);
  box-shadow: inset 0 2px 8px rgba(120, 120, 120, 0);
}

.gradient-border {
  position: relative;
  margin: auto;
  border-radius: 10px;
  transition: all .3s;
}

.gradient-border:hover {
  filter: contrast(1.1);
}

.gradient-border:active {
  filter: contrast(0.9);
}

.gradient-border::before,
.gradient-border::after {
  content: "";
  position: absolute;
  top: 1px;
  left: 1px;
  right: 1px;
  bottom: 1px;
  border: 3px solid #A5ADF6;
  transition: all .3s;
  animation: clippath 2s infinite linear;
  border-radius: 10px;
}

.gradient-border::after {
  animation: clippath 2s infinite -1s linear;
}

@keyframes clippath {

  0%,
  100% {
    clip-path: inset(0 0 98% 0);
  }

  25% {
    clip-path: inset(0 98% 0 0);
  }

  50% {
    clip-path: inset(98% 0 0 0);
  }

  75% {
    clip-path: inset(0 0 0 98%);
  }
}

.dirBtn {
  background: #7D7D7D;
  padding: 6px 8px;
  font-size: 14px;
  border-radius: 5px;

  span {
    color: #FFFFFF;
  }
}
</style>
