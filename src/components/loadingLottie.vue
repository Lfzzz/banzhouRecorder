<template>
  <Vue3Lottie
    :autoPlay="true"
    :animationData="loading"
    :loop="true"
    height="168px"
    width="168px"
  />
</template>
<script>
import { defineComponent } from "vue";
import { Vue3Lottie } from "vue3-lottie";
import loading from "@/assets/lotties/loading1.json";
export default defineComponent({
  name: "LoadingLottie", //组件名称
  components: {
    Vue3Lottie,
  },
  setup() {
    return {
      loading,
    };
  },
});
</script>
