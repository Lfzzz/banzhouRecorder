<template>
  <div class="dragNav ball flex justify-center items-center">
    <div class="flex items-center">
      <span class="timeText">{{ videoTime.slice(0, 2) }}</span>
      <span class="timeText relative mx-1" style="top: -2px">:</span>
      <span class="timeText">{{ videoTime.slice(3, 5) }}</span>
      <span class="timeText relative mx-1" style="top: -2px">:</span>
      <span class="timeText">{{ videoTime.slice(-2) }}</span>
    </div>
  </div>
</template>
<script>
import { defineComponent, reactive, toRefs } from "vue";
const { ipcRenderer } = window.require("electron");
export default defineComponent({
  name: "Suspend", // 组件名称
  setup() {
    const state = reactive({
      videoTime: "00:00:00",
    });

    ipcRenderer.on("timeChange", (event, data) => {
      state.videoTime = data;
    });

    return {
      ...toRefs(state),
    };
  },
});
</script>
<style scoped lang="scss">
.dragNav {
  -webkit-app-region: drag;
}

.ball {
  width: 100%;
  height: 100%;
  border-radius: 8px;
  background: #a5adf6;
}

.timeText {
  font-size: 20px;
  color: #ffffff;
}
</style>
