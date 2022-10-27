import { createApp } from "vue"; // 导⼊ createApp ⽅法
import Loading from "../components/loading.vue"; // 导⼊我们写好的 loading 组件
const relative = "g-relative"; // g-relative 全局相对定位样式名称
const hidden = "g-hidden"; // g-hidden 全局禁止/隐藏滚动样式名称

// 插入节点
function append(el) {
  const style = getComputedStyle(el);
  el.appendChild(el.instance.$el);
  setTimeout(() => {
    const mask = el.getElementsByClassName("mask")[0];
    const loadingClass = el.getElementsByClassName("loadingClass")[0];
    el.classList.add(hidden); // 添加类名
    if (["absolute", "relative", "fixed"].indexOf(style.position) === -1) {
      el.classList.add(relative); // 添加类名
    }
    mask.classList.add("maskShow");
    setTimeout(() => {
      loadingClass.classList.add("animate__animated");
      loadingClass.classList.add("animate__zoomIn");
    }, 300);
    // 向el节点插⼊动态创建的 div 节点，内容就是我们的 loading 组件
  }, 1);
}
// 移除节点
function remove(el) {
  setTimeout(() => {
    const mask = el.getElementsByClassName("mask")[0];
    const loadingClass = el.getElementsByClassName("loadingClass")[0];
    loadingClass.classList.remove("animate__bounceIn"); // 移除类名
    loadingClass.classList.add("animate__zoomOut");
    setTimeout(() => {
      mask.classList.remove("maskShow"); // 移除类名
      mask.classList.add("maskOut");
    }, 150);
    setTimeout(() => {
      mask.classList.remove("maskOut"); // 移除类名
      loadingClass.classList.remove("animate__animated"); // 移除类名
      loadingClass.classList.remove("animate__zoomOut"); // 移除类名
      // 移除动态创建的 div 节点
      el.removeChild(el.instance.$el);
      el.classList.remove(relative); // 移除类名
      el.classList.remove(hidden); // 移除类名
    }, 800);
  }, 1);
}

const loadingDirective = {
  mounted(el, binding) {
    // 创建app对象跟组件为我们写好的 loading 组件
    const app = createApp(Loading);

    // 动态创建⼀个div节点，将app挂载在div上
    // 我们的 loading 组件将替换此 div 标签的 innerHTML
    const instance = app.mount(document.createElement("div"));

    // 因为在updated也需要⽤到 instance 所以将 instance 添加在 el 上
    // 在 updated中 通过el.instance 可访问到
    el.instance = instance;

    // v-loading传过来的值储存在 binding.value 中
    if (binding.value) {
      append(el);
    }

    // 在此判断是否有title值
    if (binding.arg !== "undefined") {
      // setTitle 使我们在loading组件中定义的⽅法
      el.instance.setTitle(binding.arg);
    }
  },
  updated(el, binding) {
    // 在此判断是否有title值
    if (binding.arg !== "undefined") {
      // setTitle 使我们在loading组件中定义的⽅法
      el.instance.setTitle(binding.arg);
    }

    // 如果value的值有改变，那么我们去判断进⾏操作
    if (binding.value !== binding.oldValue) {
      // 三元表达式 true 插入 false 移除
      binding.value ? append(el) : remove(el);
    }
  },
};

export default loadingDirective;
