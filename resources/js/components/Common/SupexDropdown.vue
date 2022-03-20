<template>
    <div class="w-full" v-click-outside="onClickOutside">
        <div class="relative">
            <div
                class="h-12 bg-white flex border-2 border-blue-500 rounded-lg items-center z-0"
                :class="{ 'border-red-500': hasError }"
            >
                <input
                    autocomplete="off"
                    name="select"
                    id="select"
                    class="px-4 appearance-none outline-none text-gray-800 w-full"
                    :placeholder="placeholder"
                    @focus="show_dropdown = true"
                    v-model="selected_item"
                    @keyup="onInputChange"
                    checked
                />
                <label
                    class="cursor-pointer outline-none focus:outline-none transition-all text-gray-300 hover:text-gray-600"
                    @click="show_dropdown = !show_dropdown"
                >
                    <font-awesome-icon
                        :icon="{ prefix: 'fas', iconName: 'angle-down' }"
                        v-if="!show_dropdown"
                        class="mx-2"
                    />
                    <font-awesome-icon
                        :icon="{ prefix: 'fas', iconName: 'angle-up' }"
                        v-if="show_dropdown"
                        class="mx-2"
                    />
                </label>
            </div>
            <div
                class="absolute rounded shadow bg-white overflow-hidden flex flex-col w-full mt-1 border border-gray-200 z-10"
                v-if="show_dropdown"
            >
                <div
                    class="cursor-pointer group"
                    v-for="(item, index) in filteredItems"
                    :key="index"
                >
                    <a
                        class="block p-2 border-transparent border-l-4 group-hover:border-blue-600 group-hover:bg-gray-100"
                        :class="{ 'border-blue-600': selected_item === item[bind_label] }"
                        @click="setSelected(item)"
                    >{{ item[bind_label] }}</a>
                </div>
                <div class="group" v-if="filteredItems.length === 0">
                    <span class="block p-2 border-transparent border-1-4">No Items</span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "SupexDropdown",
    props: {
        items: {
            type: Array,
            default: []
        },
        placeholder: {
            type: String,
            required: true,
            default: ""
        },
        bind_label: {
            type: String,
            required: true,
            default: ''
        },
        bind_value: {
            type: String,
            required: true,
            default: ''
        },
        hasError: {
            type: Boolean,
            required: false,
            default: false
        },
        selected: {
            type: String,
            required: true,
            default: ''
        }
    },
    data() {
        var bindLabel = '';
        var item = this.items.find(item => item[this.bind_value] == this.selected);
        if (item) bindLabel = item[this.bind_label];

        return {
            selected_item: bindLabel,
            show_dropdown: false,
            filteredItems: this.items
        }
    },
    watch: {
        items() {
            this.filteredItems = this.items;

            var bindLabel = '';
            var item = this.items.find(item => item[this.bind_value] == this.selected);
            if (item) bindLabel = item[this.bind_label];
            this.selected_item = bindLabel;
        },
    },
    methods: {
        setSelected: function (item) {
            this.selected_item = item[this.bind_label];
            this.show_dropdown = false;
            this.$emit('selected', item[this.bind_value]);
        },
        onInputChange: function (event) {
            const currentVal = event.target.value;
            this.filteredItems = this.items.filter(item => item[bind_label].includes(currentVal));
        },
        onClickOutside: function () {
            this.show_dropdown = false;
        }
    }
}
</script>

<style scoped>
</style>
