import { createApp } from "vue";
import App from "./App.vue";

// import router
import router from "./router";

// import font awesome icons
import { library } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { fas } from "@fortawesome/free-solid-svg-icons";
library.add(fas);
import { fab } from "@fortawesome/free-brands-svg-icons";
library.add(fab);
import { far } from "@fortawesome/free-regular-svg-icons";
library.add(far);
import { dom } from "@fortawesome/fontawesome-svg-core";
dom.watch();

// import click-outside-vue3
import vClickOutside from "click-outside-vue3";

// import Vuex
import { createStore } from "vuex";

// Create a new store instance
const store = createStore({
    state() {
        return {
            settings: {}
        }
    },
    mutations: {
        setSettings(state, payload) {
            state.settings = payload;
        }
    },
    getters: {
        getSettings: (state) => () => {
            return state.settings;
        }
    }
})

// import Skeletor
import { Skeletor } from 'vue-skeletor';

const app = createApp(App);
app.use(router);
app.use(vClickOutside);
app.use(store);
app.component("font-awesome-icon", FontAwesomeIcon);
app.component(Skeletor.name, Skeletor);
app.mount("#app");

require("./bootstrap");
