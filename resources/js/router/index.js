import { createWebHistory, createRouter } from "vue-router";

// import pages
import Home from "../pages/Home.vue";
import QuestionGenerator from "../pages/QuestionGenerator.vue";
import Studio from "../pages/Studio.vue";
import Training from "../pages/Training.vue";

const routes = [
    {
        path: "/",
        name: "Home",
        component: Home,
    },
    {
        path: "/question-generator",
        name: "QuestionGenerator",
        component: QuestionGenerator,
    },
    {
        path: "/studio",
        name: "Studio",
        component: Studio,
    },
    {
        path: "/training",
        name: "Training",
        component: Training,
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
