<template>
  <div
    class="flex flex-col h-full overflow-hidden"
    :style="{ transformOrigin: toClose ? '100% 0%' : '50% 100%' }"
    style="background: #d1d5e3ff; transition: 0.2s"
  >
    <div
      class="flex items-center justify-between flex-row h-14 w-screen select-none pr-2 dragNav"
      style="background: rgba(174, 182, 212, 1)"
    >
      <!-- 左侧logo 可拖动 -->
      <div class="flex flex-1 p-2 h-full">
        <div
          class="flex h-full items-center py-1 px-2 rounded-bl-2xl rounded-tr-2xl"
          style="background: rgba(255, 255, 255, 0.6)"
        >
          <img class="h-full" src="@/assets/images/logo.png" alt="" srcset="" />
          <span class="text-indigo-600 ml-1 text-lg">伴舟录屏</span>
        </div>
      </div>
      <!-- 右侧 缩小&关闭 按钮 -->
      <div class="flex items-center mr-1">
        <div
          @click="handleMinimize"
          @mouseenter="hasHoverClass = true"
          class="flex justify-center items-center h-8 w-8 rounded-bl-xl dragBtn"
          :class="[hasHoverClass ? 'hoverSwek' : '']"
          style="background: rgba(248, 235, 211, 1)"
        >
          <span
            class="w-6 h-1 rounded-2xl"
            style="background: #fccf72; width: 20px; height: 3px"
          ></span>
        </div>
        <div
          @click="handleClose"
          @mouseenter="hasHoverClass = true"
          class="flex justify-center items-center h-8 w-8 rounded-tr-xl relative dragBtn"
          :class="[hasHoverClass ? 'hoverClose' : '']"
          style="background: #f6dddf"
        >
          <span
            class="rounded-2xl absolute left-0 top-0 bottom-0 right-0 m-auto rotate-45"
            style="background: #fc7e7e; width: 20px; height: 2px"
          ></span>
          <span
            class="rounded-2xl absolute left-0 top-0 bottom-0 right-0 m-auto -rotate-45"
            style="background: #fc7e7e; width: 20px; height: 2px"
          ></span>
        </div>
      </div>
    </div>
    <div
      class="flex-1 py-7 px-7 flex h-full relative overflow-hidden"
      style="background: #d1d5e3"
    >
      <slot name="finishSlot"></slot>
      <div
        class="flex flex-col flex-1 mr-4 rounded-bl-3xl rounded-tr-3xl h-full w-0 relative"
        style="background: rgba(239, 241, 245, 0.6)"
      >
        <div
          class="flex justify-center items-center w-28 select-none h-10 text-white text-lg -mt-2 -ml-1 rounded-br-3xl shadow-lg flex-shrink-0 mb-4 absolute left-0 top-0"
          style="background: #a5adf6; z-index: 100"
        >
          录屏记录
        </div>
        <slot name="recordList"></slot>
      </div>
      <div class="ml-4 w-1/2 flex-shrink-0">
        <div class="flex flex-col justify-between h-full">
          <div
            class="w-full mb-4 rounded-bl-3xl rounded-tr-3xl overflow-hidden"
            style="background: rgba(239, 241, 245, 0.6); height: 55%"
          >
            <slot name="rightMainWindow"></slot>
          </div>
          <div
            class="w-full flex-1 rounded-bl-3xl rounded-tr-3xl"
            style="background: rgba(239, 241, 245, 0.6)"
          >
            <slot name="rightSettingWindow"></slot>
          </div>
        </div>
      </div>
      <slot name="dialogSlot"></slot>
    </div>
  </div>
</template>
<script>
import { defineComponent, reactive, toRefs } from "vue";
const { ipcRenderer } = window.require("electron");

export default defineComponent({
  name: "Layer", //组件名称
  setup() {
    const state = reactive({
      hasHoverClass: true,
      toClose: false,
    });

    const handleMinimize = () => {
      ipcRenderer.send("main_minize");
      state.hasHoverClass = false;
    };

    const handleClose = () => {
      ipcRenderer.send("main_close");
    };

    return {
      ...toRefs(state),
      handleMinimize,
      handleClose,
    };
  },
});
</script>
<style scoped lang="scss">
.dragNav {
  -webkit-app-region: drag;
}

.dragBtn {
  -webkit-app-region: no-drag;
}

.hoverSwek:hover {
  background: #fccf72 !important;
  transition: 0.2s;
}

.hoverSwek:hover span {
  background: #ffffff !important;
  transition: 0.2s;
}

.hoverClose:hover {
  background: #fc7e7e !important;
  transition: 0.2s;
}

.hoverClose:hover span {
  background: #ffffff !important;
  transition: 0.2s;
}
</style>
