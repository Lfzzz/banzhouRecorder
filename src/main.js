import { createApp } from "vue";
import cScrollbar from "c-scrollbar";
import App from "./App.vue";
import router from "./router";
import "@/assets/styles/comm.scss";
import "@/assets/styles/reset.scss";
import Vue3Lottie from "vue3-lottie";
import "vue3-lottie/dist/style.css";
import "./index.css";
import "animate.css/animate.min.css";
import loadingDirective from "@/directives/loading.js";

const app = createApp(App);
app
  .use(router)
  .use(Vue3Lottie)
  .use(cScrollbar)
  .directive("loading", loadingDirective)
  .mount("#app");
