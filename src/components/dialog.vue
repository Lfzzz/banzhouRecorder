<template>
  <div
    v-show="modelValue"
    @click.self="closeDialog"
    :class="[
      showDialog
        ? 'animate__animated animate__fadeIn'
        : 'animate__animated animate__fadeOut animate__delay-1',
    ]"
    class="absolute flex justify-center items-center w-full h-full left-0 top-0 select-none animate__fast2 shadow"
    style="
      background: rgba(0, 0, 0, 0.1);
      opacity: 0;
      backdrop-filter: blur(5px);
    "
  >
    <div
      :class="[
        showDialog
          ? 'animate__animated animate__bounceIn animate__delay-1'
          : 'animate__animated animate__zoomOut',
      ]"
      class="rounded-tr-3xl rounded-bl-3xl overflow-hidden w-3/4 animate__fast2 pb-7 flex flex-col"
      style="
        background: #ffffff;
        position: relative;
        top: -30px;
        max-height: 30rem;
      "
    >
      <div
        class="w-full h-10 flex justify-between items-center pl-3 pr-3 flex-shrink-0"
        style="background: #5a7ce4"
      >
        <div class="flex items-center">
          <img
            v-if="icon"
            :src="icon"
            class="mr-2"
            style="width: 20px; height: 20px"
          />
          <span class="text-xl text-white">{{ title }}</span>
        </div>
        <div
          @click="closeDialog"
          class="flex justify-center items-center h-7 w-7 rounded-full relative"
        >
          <span
            class="rounded-2xl absolute left-0 top-0 bottom-0 right-0 m-auto rotate-45 shadow"
            style="background: #ffffff; width: 18px; height: 2px"
          ></span>
          <span
            class="rounded-2xl absolute left-0 top-0 bottom-0 right-0 m-auto -rotate-45 shadow"
            style="background: #ffffff; width: 18px; height: 2px"
          ></span>
        </div>
      </div>
      <div class="flex-1 overflow-x-auto h-0 p-1 dialog">
        <c-scrollbar
          width="100%"
          height="100%"
          trigger="hover"
          :vBarStyle="{ 'background-color': 'rgba(255,255,255, 1)' }"
          :vThumbStyle="{ 'background-color': 'rgba(90, 124, 228,.2)' }"
        >
          <slot></slot>
        </c-scrollbar>
      </div>
      <div class="w-full flex-shrink-0">
        <slot name="footer"></slot>
      </div>
    </div>
  </div>
</template>
<script>
import { defineComponent, reactive, toRefs, watch } from "vue";
export default defineComponent({
  name: "Dialog", //组件名称
  props: {
    modelValue: {
      type: Boolean,
    },
    title: String,
    icon: String,
  },
  setup(props, ctx) {
    const state = reactive({
      showDialog: false,
    });

    watch(
      () => props.modelValue,
      (newValue) => {
        state.showDialog = newValue;
      }
    );
    const closeDialog = () => {
      state.showDialog = false;
      setTimeout(() => {
        ctx.emit("update:modelValue", false);
      }, 500);
    };
    return {
      closeDialog,
      ...toRefs(state),
    };
  },
});
</script>
