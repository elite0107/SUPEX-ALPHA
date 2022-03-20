<template>
    <div
        class="count-button py-4 w-full flex justify-around border rounded-lg"
        :class="{ 'border-red-500': hasError }"
    >
        <button
            class="action-btn rounded-full"
            @click="$emit('btnClicked', 'minus')"
        >
            <font-awesome-icon :icon="{prefix: 'fas', iconName: 'minus'}" />
        </button>
        <slot />
        <button
            class="action-btn rounded-full"
            @click="$emit('btnClicked', 'plus')"
        >
            <font-awesome-icon :icon="{prefix: 'fas', iconName: 'plus'}" />
        </button>
    </div>
</template>

<script>
export default {
    name: 'QuestionCountButton',
    props: {
        hasError: {
            type: Boolean,
            default: false,
            required: false
        }
    }
}
</script>

<style scoped>
    .count-button {
        background: #F9F9F9;
    }
    .action-btn {
        width: 24px;
        height: 24px;
        background: #2D2929;
        color: white;
    }
</style>
