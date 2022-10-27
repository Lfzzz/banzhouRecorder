import { createRouter, createWebHashHistory } from "vue-router";

const routes = [
  {
    path: "/launch",
    name: "Launch",
    component: () => import("@/views/launch.vue"),
  },
  {
    path: "/dashboard",
    name: "Dashboard",
    component: () => import("@/views/dashboard.vue"),
  },
  {
    path: "/suspend",
    name: "Suspend",
    component: () => import("@/views/suspend.vue"),
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
