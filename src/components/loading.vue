<template>
  <div class="mask">
    <div class="loader">
      <loadingLottie class="loadingClass" />
      <div class="tip-text">{{ title }}</div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineExpose } from "vue";
import loadingLottie from "./loadingLottie.vue";

let title = ref(""); // 加载提示文字
// 更改加载提示文字
const setTitle = (val) => {
  title.value = val;
};

// 暴露出去
defineExpose({
  title,
  setTitle,
});
</script>

<style lang="scss" scoped>
.loadingClass {
  animation-fill-mode: forwards !important;
  animation-duration: 0.8s !important;
}

.mask {
  width: 100%;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
  background-color: rgba(221, 224, 234, 0.9);
  z-index: 99;
  opacity: 0;

  .loader {
    position: absolute;
    top: 50%;
    left: 40%;
    margin-left: 10%;
    transform: translate3d(-50%, -50%, 0);
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .tip-text {
    color: #3793ff;
    padding-top: 10px;
  }
}
</style>
