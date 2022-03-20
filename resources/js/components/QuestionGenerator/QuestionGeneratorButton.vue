<template>
    <button
        class="relative py-4 w-full qg-button rounded-lg"
        :class="{'selected': selected}"
        @click="$emit('btnClicked')"
    >
        <slot />
        <span
            class="checked absolute translate-x-1/2 -translate-y-1/2 right-2 top-2 rounded-full flex items-center justify-center"
            v-if="selected"
        >
            <font-awesome-icon :icon="{prefix: 'fas', iconName: 'check'}"/>
        </span>
    </button>
</template>

<script>
export default {
    name: "QuestionGeneratorButton",
    props: {
        selected: {
            type: Boolean,
            default: false,
            required: false,
        }
    },
}
</script>

<style scoped>
    .qg-button {
        background: #f9f9f9;
        font-size: 1rem;
        font-weight: bold;
        line-height: 1.25rem;
        color: #282727;
    }

    .qg-button:hover {
        background: #282727;
        color: white;
    }

    .qg-button.selected {
        background: #282727;
        color: white;
    }

    .qg-button.selected .checked {
        border: 2px solid #282727;
        background: #f9f9f9;
        color: #282727 !important;
        width: 25px;
        height: 25px;
    }
</style>
