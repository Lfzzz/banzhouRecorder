<template>
  <div class="flex justify-center items-center" v-show="!modelValue">
    <img
      :style="{ width: width + 'px', height: height + 'px' }"
      :src="icon"
      v-if="icon"
    />
    <span :style="{ color: textColor }" class="ml-1">{{ title }}</span>
  </div>
  <div v-show="modelValue">
    <Vue3Lottie
      ref="lottieAnimate"
      :autoPlay="true"
      :animationData="btnLoading"
      :loop="true"
      :speed="1.5"
      height="168px"
      width="168px"
    />
  </div>
</template>
<script>
import { defineComponent, ref, watch } from "vue";
import { Vue3Lottie } from "vue3-lottie";
import btnLoading from "@/assets/lotties/btnLoading.json";
export default defineComponent({
  name: "BtnLoadingText", //组件名称
  components: {
    Vue3Lottie,
  },
  props: {
    modelValue: {
      type: Boolean,
    },
    title: String,
    icon: String,
    width: Number,
    height: Number,
    textColor: String,
  },
  setup(props) {
    const lottieAnimate = ref(null);

    watch(
      () => props.modelValue,
      (newValue) => {
        console.log(newValue, lottieAnimate.value);
        if (!newValue) {
          lottieAnimate.value.stop();
        } else {
          lottieAnimate.value.play();
        }
      }
    );

    return {
      btnLoading,
      lottieAnimate,
      stop,
    };
  },
});
</script>
