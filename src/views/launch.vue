<template>
  <div
    class="page-wrapper flex items-center justify-center launch-page select-none rounded-bl-3xl rounded-tr-3xl"
  >
    <Vue3Lottie
      :animationData="lottieData"
      :delay="500"
      :loop="false"
      height="auto"
      width="80%"
    />
  </div>
</template>
<script>
import { defineComponent } from "vue";
import lottieData from "@/assets/lotties/data.json";

export default defineComponent({
  name: "Launch", // 组件名称
  setup() {
    return {
      lottieData,
    };
  },
});
</script>
<style scoped lang="scss">
.launch-page {
  background: $color-bg-theme;
  display: flex;
  justify-content: center;
  align-items: center;

  p {
    color: #ffffff;
    font-size: 40px;
  }
}
</style>
